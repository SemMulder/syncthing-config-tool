final: prev:
{
  syncthing-config-tool = final.buildGoModule rec {
    pname = "syncthing-config-tool";
    version = "0.0.3";

    src = ./.;
    vendorHash = "sha256-rHbmo2niZHzEUjKogI6bPRVy0IPGKxNSTrOs3oa/Z0Q=";

    meta = with final.lib; {
      description = "Utility for validating and converting Syncthing configurations between JSON and XML.";
      homepage = "https://github.com/SemMulder/syncthing-config-tool";
    };
  };
}
