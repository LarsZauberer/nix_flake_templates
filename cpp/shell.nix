{
  mkShell,
  package,
}:
mkShell {
  name = "devshell";

  inputsFrom = package.buildInputs;
}
