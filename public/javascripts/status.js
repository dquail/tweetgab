
var Status = Backbone.Model.extend({
});

var Statuses = Backbone.Collection.extend({
  model: Status
});

var StatusView = Backbone.View.extend({
  initialize: function() {
    $('#statuses').prepend(this.el);
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
  },
  statuses: new Statuses(),
  statusViews: [],
  add: function(status) {
    this.statusViews.push(new StatusView({
      model: status,
      id: "status-" + status.id
    }));
  }
}
StatusController.initialize();