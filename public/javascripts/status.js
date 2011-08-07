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
    $(this.el).html("This is a status rendered at " + new Date());
    return this;
  }
});

var StatusController = {
  initialize: function() {
    var self = this;
    StatusController.statuses.bind("add", this.add, this);
    StatusController.statuses.bind("remove", this.remove, this);
    StatusController.statuses.bind("reset", this.reset, this);
    StatusController.statuses.reset([
      {id: 'foo'},
      {id: 'bar'},
      {id: 'baz'},
      {id: 'qux'},
      {id: 'quux'},
      {id: 'quz'}
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