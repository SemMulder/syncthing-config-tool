final: prev:
{
  syncthing-config-tool = final.buildGoModule rec {
    pname = "syncthing-config-tool";
    version = "0.0.4";

    src = ./.;
    vendorHash = "sha256-izhJMnXmzr6eZreH7/SKp/B1aVqFzoza83y0ukijuIQ=";

    meta = with final.lib; {
      description = "Utility for validating and converting Syncthing configurations between JSON and XML.";
      homepage = "https://github.com/SemMulder/syncthing-config-tool";
    };
  };
}
