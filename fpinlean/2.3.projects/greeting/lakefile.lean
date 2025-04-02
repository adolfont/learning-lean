import Lake
open Lake DSL

package "greeting" where
  version := v!"0.1.0"

lean_lib «Greeting» where
  -- add library configuration options here

@[default_target]
lean_exe "greeting" where
  root := `Main
