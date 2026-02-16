enum VisibilityStateEnum {
  publicState,
  privateState,
}

VisibilityStateEnum visibilityStateFromJson(String value) {
  switch (value) {
    case 'Public':
      return VisibilityStateEnum.publicState;
    case 'Private':
      return VisibilityStateEnum.privateState;
    default:
      return VisibilityStateEnum.privateState; // fallback propre
  }
}

String visibilityStateToJson(VisibilityStateEnum state) {
  switch (state) {
    case VisibilityStateEnum.publicState:
      return 'Public';
    case VisibilityStateEnum.privateState:
      return 'Private';
  }
}
