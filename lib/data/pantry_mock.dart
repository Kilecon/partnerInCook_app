import 'package:partner_in_cook/model/pantry.dart';
import 'package:partner_in_cook/data/fridge_mock.dart' as fridge_mock;

final Pantry pantryHome = Pantry(
  id: 'p_home',
  name: 'Garde-manger Maison',
  fridges: fridge_mock.fridgesMock,
);

final Pantry pantrySmall = Pantry(
  id: 'p_small',
  name: 'Petit garde-manger',
  fridges: [fridge_mock.fridge1],
);

final Pantry pantryEmpty = Pantry(
  id: 'p_empty',
  name: 'Garde-manger vide',
  fridges: [],
);

final List<Pantry> pantriesMock = [pantryHome, pantrySmall, pantryEmpty];

final Pantry pantryMock = pantryHome;
