final: prev:
{
  syncthing-config-tool = final.buildGoModule rec {
    pname = "syncthing-config-tool";
    version = "0.0.2";

    src = ./.;
    vendorHash = "sha256-jrGJChEexVmQP5jnUofAbtwB67uX2ysBzA3pFBbn/Og=";

    meta = with final.lib; {
      description = "Utility for validating and converting Syncthing configurations between JSON and XML.";
      homepage = "https://github.com/SemMulder/syncthing-config-tool";
    };
  };
}
