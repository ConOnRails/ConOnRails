var stage = null;
var cards = [];

function dismiss(evt) {
  var shape = evt.targetNode;
  cards.pop();
  layout();
}

function goto_event(evt) {
  var shape = evt.targetNode;
  console.log(shape);
  location.assign('/events/' + shape.getAttr('name'));
}

function card(id, text) {
  var rect = new Kinetic.Rect({
    x: 0,
    y: 5,
    width: 190,
    height: 90,
    fill: '#dddddd',
    stroke: 'black',
    strokeWidth: 4,
    cornerRadius: 10,
    name: id
  });

  var text = new Kinetic.Text({
    x: 5,
    y: 10,
    width: 185,
    text: text,
    fontSize: 11,
    fontFamily: 'Calibri',
    fill: '#555',
    name: id
  });

  var group = new Kinetic.Group({ name: id
  }).on('click tap', goto_event);

  group.add(rect);
  group.add(text);
  return group;
}

function fill_cards(data, status, xhr) {
  for (var i = 0; i < data.length; i++) {
    cards.push(card(data[i].id, data[i].entry));
  }
  layout();
}

function get_events() {
  $.ajax({
    url: '/events',
    dataType: 'json',
    success: fill_cards
  });
}

function layout() {
  stage = new Kinetic.Stage({
    container: 'cork-board',
    width: 780,
    height: 100,
    fill: '#999999'
  });

  var layer = new Kinetic.Layer();
  for (var i = 0; i < cards.length; i++) {
    cards[i].setAttr('x', cards[i].getAttr('x') + 195 * i);
    layer.add(cards[i])
  }

  // add the layer to the stage
  stage.add(layer);
}

function cork_board() {
  get_events();
}