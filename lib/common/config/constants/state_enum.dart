enum State {
  publicState,
  privateState,
}

State stateFromJson(String value) =>
    State.values.firstWhere((e) => e.name == value);

String stateToJson(State state) => state.name;
