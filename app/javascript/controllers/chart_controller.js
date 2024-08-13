import { Controller } from "@hotwired/stimulus";
import { Sunburst } from "../charts/sunburst";

// Connects to data-controller="chart"
export default class extends Controller {
  static values = {
    title: String,
    currentMonth: String
  }

  initialize() {
    this.resizeChart = this.resizeChart.bind(this);
  }

  async connect() {
    // turbo makes the connect callback called twice
    // see https://stackoverflow.com/a/78393096
    if (document.documentElement.hasAttribute('data-turbo-preview')) {
      return;
    }

    const dashboardExpenses = await this.fetchDashboardExpenses();
    if (dashboardExpenses.length === 0) {
      return;
    }

    this.sunburst = new Sunburst({ 
      element: this.element,
      data: dashboardExpenses,
      title: this.titleValue,
      theme: this.theme()});

    window.addEventListener('resize', this.resizeChart);
    this.sunburst.render();
  }

  disconnect() {
    document.removeEventListener('resize', this.resizeChart)
    this.sunburst?.dispose();
  }

  resizeChart() {
    this.sunburst.resize()
  }

  theme() {
    if(window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      return 'dark'
    }

    return null
  }

  async fetchDashboardExpenses() {
    const response = await fetch(`dashboard/expenses?${new URLSearchParams({
      current_month: this.currentMonthValue
    }).toString()}`)

    return await response.json()
  }
}
