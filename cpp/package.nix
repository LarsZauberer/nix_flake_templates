{
  pname,
  version,
  pkgs,
}:
pkgs.stdenv.mkDerivation {
  inherit pname version;

  src = ./.;

  buildInputs = with pkgs; [
    gcc
    gnumake
  ];

  buildPhase = ''
    g++ -o ${pname} main.cpp
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib
    mkdir -p $out/include

    cp ${pname} $out/${pname}
  '';
}
