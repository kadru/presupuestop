// Import and register all your controllers from the importmap under controllers/*

import { registerControllers } from 'stimulus-vite-helpers'
import { application } from "@/controllers/application"

const controllers = import.meta.glob('./**/*_controller.js', { eager: true })
registerControllers(application, controllers)

// Eager load all controllers defined in the import map under controllers/**/*_controller
//import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
