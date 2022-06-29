# frozen_string_literal: true

class CaseReflex < ApplicationReflex
  # Add Reflex methods in this file.
  #
  # All Reflex instances include CableReady::Broadcaster and expose the following properties:
  #
  #   - connection  - the ActionCable connection
  #   - channel     - the ActionCable channel
  #   - request     - an ActionDispatch::Request proxy for the socket connection
  #   - session     - the ActionDispatch::Session store for the current visitor
  #   - flash       - the ActionDispatch::Flash::FlashHash for the current request
  #   - url         - the URL of the page that triggered the reflex
  #   - params      - parameters from the element's closest form (if any)
  #   - element     - a Hash like object that represents the HTML element that triggered the reflex
  #     - signed    - use a signed Global ID to map dataset attribute to a model eg. element.signed[:foo]
  #     - unsigned  - use an unsigned Global ID to map dataset attribute to a model  eg. element.unsigned[:foo]
  #   - cable_ready - a special cable_ready that can broadcast to the current visitor (no brackets needed)
  #   - reflex_id   - a UUIDv4 that uniquely identies each Reflex
  #
  # Example:
  #
  #   before_reflex do
  #     # throw :abort # this will prevent the Reflex from continuing
  #     # learn more about callbacks at https://docs.stimulusreflex.com/lifecycle
  #   end
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com/reflexes#reflex-classes

  def update_notes
    Case.find_by(id: element.dataset[:id])&.update notes: element[:value]
    morph :nothing
  end

  def update_next
    Case.find_by(id: element.dataset[:id])&.update next_steps: element[:value]
    morph :nothing
  end  

  def update_tags
    Case.find_by(id: element.dataset[:id])&.update tags: element[:value]
    morph :nothing
  end

  def update_test
    Case.find_by(id: element.dataset[:id])&.update test_case_id: element[:value]
    morph :nothing
  end  

  def change_status
    session[:case_case_status] = element[:value]
  end

  def change_no
    session[:case_case_no] = element[:value]
  end

  def change_priority
    session[:case_case_priority] = element[:value]
  end

  def change_tracked
    track_status = session[:case_case_tracked] || false
    session[:case_case_tracked] = !track_status
  end
end
