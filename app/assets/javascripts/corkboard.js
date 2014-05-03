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
      var $card = $(document.createElement('div'));
      var $object = $('#cork-board').append($card);

      $card.addClass('index-card');
      if (this.currentID() == id) {
        $card.addClass('selected-card');
      }
      $card.html(text);
      $card.data('event-id', id);
      $card.on('click tap', this.gotoEvent).bind(this);
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
      $('#cork-board').html('');

      if (data.length == 0) {
        $('#cork-board').hide();
      } else {
        for (var i = 0; i < data.length; i++) {
          this.cards.push(this.card(data[i].id, data[i].entry));
        }

        //  this.layout();
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
      var $target = $(evt.target).closest('.index-card');
      console.log($target);
      location.assign('/events/' + $target.data('event-id'));
    }
  }
}();









