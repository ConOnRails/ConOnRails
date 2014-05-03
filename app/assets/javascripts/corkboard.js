!function () {
  CIAB.Corkboard = function (tag) {
    this.cards = [];
    this.tag = tag;

    this.init();
  };

  CIAB.Corkboard.prototype = {
    init: function () {
      this.$cork_space = $('#cork-board');

      this.$cork_board = $(document.createElement('div'));
      this.$cork_space.append(this.$cork_board);
      this.$cork_board.addClass('cork-board');

      this.$cork_label = $(document.createElement('div'));
      this.$cork_space.append(this.$cork_label);
      this.$cork_label.addClass('cork-board-label');
      this.$cork_label.html(this.tag);

      this.getEvents();
    },

    card: function (id, text) {
      var $card = $(document.createElement('div'));

      this.$cork_board.append($card);
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
      this.$cork_board.html('');

      if (data.length == 0) {
        this.$cork_board.hide();
      } else {
        for (var i = 0; i < data.length; i++) {
          this.cards.push(this.card(data[i].id, data[i].entry));
        }
        this.$cork_board.show()
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









