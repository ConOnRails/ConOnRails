!function(app)
{
  app.Corkboard = function()
  {
    this.stage = null;
    this.cards = [];

    this.init();
  }

  app.Corkboard.prototype = {
    init: function() {
      this.getEvents();
    },

    card: function(id, text) {
      var rect = new Kinetic.Rect({
        x: 5,
        y: 5,
        width: 190,
        height: 90,
        fill: '#eeeeee',
        stroke: 'black',
        strokeWidth: 4,
        cornerRadius: 10,
        name: id
      });

      var text = new Kinetic.Text({
        x: 15,
        y: 15,
        width: 185,
        text: text,
        fontSize: 12,
        fontFamily: 'Verdana',
        fill: '#555',
        name: id
      });

      var group = new Kinetic.Group({ name: id
      }).on('click tap', this.gotoEvent.bind(this));

      group.add(rect);
      group.add(text);
      return group;
    },

    fillCards: function(data, status, xhr) {
      for (var i = 0; i < data.length; i++) {
        this.cards.push(this.card(data[i].id, data[i].entry));
      }
      this.layout();
    },

    getEvents: function() {
      $.ajax({
        url: '/events',
        dataType: 'json',
        success: this.fillCards.bind(this)
      });
    },

    gotoEvent: function(evt) {
      var shape = evt.targetNode;
      console.log(shape);
      location.assign('/events/' + shape.getAttr('name'));
    },

    layout: function() {
      this.stage = new Kinetic.Stage({
        container: 'cork-board',
        width: 780,
        height: 100,
        fill: '#ffffff'
      });

      var layer = new Kinetic.Layer({fill: '#ffffff'});
      for (var i = 0; i < this.cards.length; i++) {
        this.cards[i].setAttr('x', this.cards[i].getAttr('x') + 200 * i);
        layer.add(this.cards[i])
      }

      // add the layer to the stage
      this.stage.add(layer);
    }

  }
} (ciab);



function dismiss(evt) {
  var shape = evt.targetNode;
  cards.pop();
  layout();
}








