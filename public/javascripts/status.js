var Status = Backbone.Model.extend({
});

var Statuses = Backbone.Collection.extend({
  model: Status
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
      "<img src='" + this.model.get('profile_img_url') + "'/>" +
      "<div class='status-text'>" + this.model.get('text') + "</div>"
    );
    return this;
  }
});

function makeFakeStatus(str) {
  return {
    id: parseInt((Math.random()*1000)),
    text: "This is a tweet. String provided was " + str,
    profile_img_url: "https://si0.twimg.com/profile_images/912184731/IMG_4626b_normal.jpg"
  }
}

var StatusController = {
  initialize: function() {
    var self = this;
    StatusController.statuses.bind("add", this.add, this);
    StatusController.statuses.bind("remove", this.remove, this);
    StatusController.statuses.bind("reset", this.reset, this);
    
    StatusController.statuses.reset([
      makeFakeStatus('foo'),
      makeFakeStatus('bar'),
      makeFakeStatus('baz'),
      makeFakeStatus('qux'),
      makeFakeStatus('quux')
    ]);
  },
  MAX_STATUSES: 5,
  statuses: new Statuses(),
  add: function(status, options) {
    new StatusView({
      model: status,
      id: "status-" + status.get('id')
    });
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