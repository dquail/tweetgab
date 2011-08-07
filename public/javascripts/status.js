var Status = Backbone.Model.extend({
});

var Statuses = Backbone.Collection.extend({
  initialize: function(models, options) {
    this.hashTag = options.hashTag;
  },
  model: Status,
  lastUpdated: new Date("2011-08-07T00:00:00Z"),
  url: function() {
    return '/hash_tags/' + this.hashTag + '/statuses.json?most_recent=' + this.lastUpdated.getTime();
  }
});

var StatusView = Backbone.View.extend({
  initialize: function() {
    $('#statuses').prepend(this.el);
    this.model.set({
      view: this
    });
    this.render();
  },
  tagName: 'div',
  className: 'status',
  events: {
    
  },
  render: function() {
    $(this.el).html(
      "<img height='48' width='48' src='" + this.model.get('profile_image_url') + "'/>" +
      "<div class='status-text'>" + this.model.get('text') + "</div><br class='clear'/>"
    );
    return this;
  }
});

function makeFakeStatus(str) {
  return {
    id: parseInt((Math.random()*1000)),
    text: "This is a tweet. String provided was " + str,
    profile_image_url: "https://si0.twimg.com/profile_images/912184731/IMG_4626b_normal.jpg"
  }
}

var StatusController = {
  initialize: function() {
    var self = this;
    StatusController.statuses.bind("add", this.add, this);
    StatusController.statuses.bind("remove", this.remove, this);
    StatusController.statuses.bind("reset", this.reset, this);
    
    StatusController.statuses.fetch({
      add: true
    });
    setInterval(function() {
      StatusController.statuses.fetch({
        add: true
      });
    }, 1000)
  },
  MAX_STATUSES: 20,
  statuses: new Statuses([], {hashTag:2}),
  add: function(status, options) {
    new StatusView({
      model: status,
      id: "status-" + status.get('id')
    });
    if (this.statuses.lastUpdated < new Date(status.get('created_at'))) {
      this.statuses.lastUpdated = new Date(status.get('created_at'));
    }
    if (!options.ignoreMax && this.statuses.length > this.MAX_STATUSES) {
      this.statuses.remove(this.statuses.first());
    }
  },
  remove: function(status) {
    if (status.get('view')) {
      status.get('view').remove();
    }
  },
  reset: function() {
    this.statuses.forEach(function(status) {
      this.add(status, {ignoreMax: true});
    }, this);
    while (this.statuses.length > this.MAX_STATUSES) {
      this.statuses.remove(this.statuses.first());
    }
  }
}

$(function() {
  StatusController.initialize();
});