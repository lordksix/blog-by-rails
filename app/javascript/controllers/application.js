/* eslint-disable import/no-unresolved */
/* eslint-disable import/prefer-default-export */

import { Application } from '@hotwired/stimulus';

const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
