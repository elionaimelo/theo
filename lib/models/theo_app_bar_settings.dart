class TheoAppBarSettings {
  TheoAppBarSettings({
    this.withBackButton = false,
    this.withMenu = false,
    this.withProfile = false,
    this.visible = false,
  });
  bool withBackButton;
  bool withProfile;
  bool withMenu;
  bool visible;

  TheoAppBarSettings copyWith({
    bool? withBackButton,
    bool? withMenu,
    bool? withProfile,
    bool? visible,
  }) {
    return TheoAppBarSettings(
      withBackButton: withBackButton ?? this.withBackButton,
      withMenu: withMenu ?? this.withMenu,
      withProfile: withProfile ?? this.withProfile,
      visible: visible ?? this.visible,
    );
  }
}
