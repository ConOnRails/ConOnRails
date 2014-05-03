!function () {
  CIAB.Corkboard = function (tag) {
    this.stage = null;
    this.cards = [];
    this.tag = tag;

    this.init();
  };

  CIAB.Corkboard.prototype = {
    init: function () {
      this.getEvents();
    },

    card: function (id, text) {
      var fill = '#eeeeee';
      var stroke = 'black';
      var textFill = '#555';
      if (this.currentID() == id) {
        fill = 'blue';
        stroke = 'white';
        textFill = 'white';
      }
      var rect = new Kinetic.Rect({
        x: 5,
        y: 5,
        width: 190,
        height: 90,
        fill: fill,
        stroke: stroke,
        strokeWidth: 4,
        cornerRadius: 10,
        name: id
      });

      var textBlock = new Kinetic.Text({
        x: 15,
        y: 15,
        width: 185,
        text: text || "",
        fontSize: 12,
        fontFamily: 'Verdana',
        fill: textFill,
        name: id
      });

      var group = new Kinetic.Group({ name: id
      }).on('click tap', this.gotoEvent.bind(this));

      group.add(rect);
      group.add(textBlock);
      return group;
    },

    currentID: function () {
      var re = /events\/(\d*)/;
      var id = re.exec(window.location);
      if (id && id.length == 2 && id[1]) {
        return id[1];
      } else {
        return null;
      }
    },

    fillCards: function (data, status, xhr) {
      if (data.length == 0) {
        $('#cork-board').hide();
      } else {
        for (var i = 0; i < data.length; i++) {
          this.cards.push(this.card(data[i].id, data[i].entry));
        }

        this.layout();
        $('#cork-board').show()
      }
    },

    getEvents: function () {
      this.cards = []
      console.log("getEvents!")

      $.ajax({
        url: '/events/tag/' + this.tag,
        dataType: 'json',
        success: this.fillCards.bind(this)
      });

      setTimeout(function () {
        this.getEvents()
      }.bind(this), 5000);
    },

    gotoEvent: function (evt) {
      var shape = evt.target;
      console.log(shape);
      location.assign('/events/' + shape.getAttr('name'));
    },

    layout: function () {
      this.bg = new Kinetic.Layer({});
      this.img = new Image();
      this.img.src = "/assets/expanded-cork.jpg";
      this.img.onload = function () {
        var image = new Kinetic.Image({image: this.img, scaleX: 100, scaleY: 100});
        this.bg.add(image);
      }.bind(this);

      this.stage = this.stage || new Kinetic.Stage({
        container: 'cork-board',
        width: 780,
        height: 100,
        fill: '#ffffff'
      });

      this.stage.clear();

      this.stage.add(this.bg);

      if (this.cards.length > 0) {
        var layer = new Kinetic.Layer({fill: '#ffffff'});
        for (var i = 0; i < this.cards.length; i++) {
          this.cards[i].setAttr('x', this.cards[i].getAttr('x') + 200 * i);
          layer.add(this.cards[i])
        }

        // add the layer to the stage
        this.stage.add(layer);
      }
    }

  }
}();

function dismiss(evt) {
  var shape = evt.targetNode;
  cards.pop();
  layout();
}








