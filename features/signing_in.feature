Feature: Signing in

Scenario: Unsuccessful Sign in

  Given a user visits the signin page
  When he submits invalid signin information
  Then he should see an error message

Scenario: Succesful Sign in
  Given a user visits the signin page
  And user has an account
  When he submits valid signin information
  Then he should see his profile page
  And he should see Sign out link.
