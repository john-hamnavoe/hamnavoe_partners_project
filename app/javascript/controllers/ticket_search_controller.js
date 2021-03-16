import ApplicationController from './application_controller'

/* This is the custom StimulusReflex controller for the TicketSearch Reflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {
  static targets = ['query', 'activity', 'count', 'list']

  connect () {
    super.connect()
    // add your code here, if applicable
  }


  beforePerform (element, reflex) {
    this.activityTarget.hidden = false
    this.countTarget.hidden = true
  }

  perform (event) {
    event.preventDefault()
    this.stimulate('TicketSearchReflex#perform', this.queryTarget.value)
  }
}
