import { Controller } from "@hotwired/stimulus";
import { PieChart } from "../charts/piechart";

// Connects to data-controller="chart"
export default class extends Controller {
  static values = {
    title: String,
    currentMonth: String
  }

  initialize() {
    this.resizeChart = this.resizeChart.bind(this);
    this.categoriesOptionId = 'categories';
  }

  async connect() {
    // turbo makes the connect callback called twice
    // see https://stackoverflow.com/a/78393096
    if (document.documentElement.hasAttribute('data-turbo-preview')) {
      return;
    }

    const expensesByCategory = await this.fetchExpensesByCategory();
    if (expensesByCategory.length === 0) {
      return;
    }

    this.chart = new PieChart(
      {
        id: this.categoriesOptionId,
        dataId: this.categoriesOptionId,
        element: this.element,
        data: expensesByCategory,
        goBackText: "Back",
        onSeriesClick: async (params, stackSize) => {
          if(stackSize === 0) {
            const amountsBySubcategory =  await this.fetchExpensesSubCategory(params.data.groupId);
            this.chart.goForward("subcategories", amountsBySubcategory);
          }
        }
      });

    window.addEventListener('resize', this.resizeChart);
    this.chart.render();
  }

  disconnect() {
    document.removeEventListener('resize', this.resizeChart)
    this.chart?.dispose();
  }

  resizeChart() {
    this.chart.resize()
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

  async fetchExpensesByCategory() {
    const response = await fetch(`dashboard/expenses/amount_by_category?${new URLSearchParams({
      current_month: this.currentMonthValue
    }).toString()}`)

    return await response.json()
  }

  async fetchExpensesSubCategory(categoryId) {
    const response = await fetch(`dashboard/expenses/${categoryId}/amount_by_subcategory?${new URLSearchParams({
      current_month: this.currentMonthValue
    }).toString()}`)

    return await response.json()
  }
}
