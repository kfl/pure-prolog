import Test.Tasty
import Test.Tasty.HUnit

import Parser
import Interp
import Ast
import Data.List (sort)


main = defaultMain tests

----------------------------------------------------------------------
-- Testing
----------------------------------------------------------------------

queryFile filename goalString search = do
  clauses <- clausesFromFile filename
  let goal = goalFromString goalString
  case (clauses, goal) of
    (Right p, Right g) -> do
       let t = makeReportTree p g
       return $ Right $ search t
    (Left err, _) ->
      return $ Left err
    (_, Left err) ->
      return $ Left err

siblings = queryFile "./tests/siblings.pl" "?- sibling(homer, X)."

extractSimples = map name . filter isSimple
  where name (Comp name _) = name
        isSimple (Comp name []) = True
        isSimple _              = False

massage (Right solutions) = Right $ sort $ concatMap gentleRub solutions
  where gentleRub (Solution bindings) =
          extractSimples $ map snd bindings
massage (Left err) = Left err

expected = sort [ "homer", "herb", "abbie", "homer", "jay"]


tests = testGroup "Siblings"
  [ testCase "DFS" $ do
      result <- siblings dfs
      Right expected @=? massage result
  , testCase "BFS" $ do
      result <- siblings bfs
      Right expected @=? massage result
  ]
