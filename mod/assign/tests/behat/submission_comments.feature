@mod @mod_assign
Feature: In an assignment, students can comment in their submissions
  In order to refine assignment submissions
  As a student
  I need to add comments about submissions

  @javascript
  Scenario: Student comments an assignment submission
    Given the following "courses" exist:
      | fullname | shortname | category | groupmode |
      | Course 1 | C1 | 0 | 1 |
    And the following "users" exist:
      | username | firstname | lastname | email |
      | student1 | Student | 1 | student1@asd.com |
    And the following "course enrolments" exist:
      | user | course | role |
      | student1 | C1 | student |
    And the following "activities" exist:
      | activity | course | idnumber | name                 | intro                       | assignsubmission_onlinetext_enabled |
      | assign   | C1     | assign1  | Test assignment name | Test assignment description | 1 |
    And I log in as "student1"
    And I follow "Course 1"
    And I follow "Test assignment name"
    When I press "Add submission"
    And I set the following fields to these values:
      | Online text | I'm the student submission |
    And I press "Save changes"
    And I click on ".comment-link" "css_element"
    And I set the field "content" to "First student comment"
    And I follow "Save comment"
    Then I should see "First student comment"
    And the field "content" matches value "Add a comment..."
    And I follow "Delete this comment"
    # Wait for the animation to finish.
    And I wait "2" seconds
    And I set the field "content" to "Second student comment"
    And I follow "Save comment"
    And I should see "Second student comment"
    And I should not see "First student comment"
    And I follow "Test assignment name"
    And I click on ".comment-link" "css_element"
    And I should see "Second student comment"
    And I should not see "First student comment"