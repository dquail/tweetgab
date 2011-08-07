
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
    return this
  }
});

var StatusController = {
  initialize: function() {
    StatusController.statuses.bind("add", this.add, this);
    StatusController.statuses.bind("remove", this.remove, this);
  },
  MAX_STATUSES: 5,
  statuses: new Statuses(),
  add: function(status) {
    new StatusView({
      model: status,
      id: "status-" + status.id
    });
    if (this.statuses.length > this.MAX_STATUSES) {
      this.statuses.remove(this.statuses.first());
    }
  },
  remove: function(status) {
    console.log("Removing ", status)
    status.get('view').remove();
  }
}
StatusController.initialize();