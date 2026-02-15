enum VisibilityStateEnum {
  publicState,
  privateState,
}

VisibilityStateEnum visibilityStateFromJson(String value) {
  switch (value) {
    case 'public':
    case 'publicState':
      return VisibilityStateEnum.publicState;
    case 'private':
    case 'privateState':
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
