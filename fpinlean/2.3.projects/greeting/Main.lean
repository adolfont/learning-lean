import Greeting
import Greeting.Smile

def main : IO Unit :=
  IO.println s!"Hello, {hello}, with {expression}!"

-- lean build
-- .lake/build/bin/greeting
