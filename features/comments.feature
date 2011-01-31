Feature: manage Comments
  In order to manage comments any user can view, add, delete, and edit these comments.
  
  Scenario: See all comments default view
    Given I am on the main comments page
    Then I should see "Welcome to Comments"

  Scenario: See a specific comment thread
    Given I am on the main comments page
    And the following comments:
      |title|body|
      |Hello There| This is my first post at this forum|
      |Can someone help me figure out how to use cucumber?| I'm new to cucumber can someone tell me how to get started?|
    When I go to comment Hello There
    Then I should see "Hello There"
    And I should see "This is my first post at this forum"
    
  Scenario: Add a comment
    Given I am on the new comment page
    When I fill in "Title" with "New Title"
    When I fill in "Body" with "HEre is a body"
    And I press "Create Comment"
    Then I should see "New Title"
    And I should see "HEre is a body"
    
  Scenario: Delete a Comment
    Given the following comments:
      |title|body|
      |Hello There| This is my first post at this forum|
      |Can someone help me figure out how to use cucumber?| I'm new to cucumber can someone tell me how to get started?|
    When I go to comment Hello There
    And I follow "Delete"
    Then I should see "Welcome to Comments"
    
  Scenario: Edit a Comment