import { Controller } from "@hotwired/stimulus";
import { Sunburst } from "../charts/sunburst";

// Connects to data-controller="chart"
export default class extends Controller {
  initialize() {
    this.resizeChart = this.resizeChart.bind(this);
  }

  async connect() {
    const dashboardExpenses = await this.fetchDashboardExpenses()
    
    this.sunburst = new Sunburst(this.element, dashboardExpenses, this.theme());
    
    window.addEventListener('resize', this.resizeChart);

    this.sunburst.render();
  }

  disconnect() {
    document.removeEventListener('resize', this.resizeChart)
    this.sunburst.dispose()
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
    const response = await fetch('dashboard/expenses')
    return await response.json()
  }
}
