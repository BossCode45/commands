{
    stdenv,
    fetchgit,
}:


stdenv.mkDerivation {
    pname = "libCommands";
    version = "0.0.1";

    #outputs = [ "out" "dev" ];

    src = fetchgit {
        url = "https://git.tehbox.org/cgit/boss/commands.git";
        rev = "v0.0.1";
        hash = "sha256-PX++smYFilMj0CjO3eIDqIBD+KrV2rv/N53kmv/kJg4=";
    };

    preInstall = "mkdir -p $out/include";
}
