Yosog
=====

Yesod tutorial code.

- to run local server:
  > cabal run -- Development

- to test server launch command.
  > cabal run -- Production -port 80
  * note that some handler won't work fine because 
    root url is set to heroku.com.
