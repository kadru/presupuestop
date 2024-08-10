import * as echarts from 'echarts/core';
import { TooltipComponent, TitleComponent} from 'echarts/components';
import { SunburstChart } from 'echarts/charts';
import { CanvasRenderer } from 'echarts/renderers';

echarts.use([
  SunburstChart,
  CanvasRenderer,
  TooltipComponent,
  TitleComponent]);

export { echarts as sunburst }

export class Sunburst {
  constructor(// element, data = [], theme = 'dark', options = {
      {
        element,
        data = [],
        theme = 'dark',
        title = 'Chart title'
      }
  ) {
    this.chart = echarts.init(element, theme)
    this.option = {
      title: {
        text: title
      },
      tooltip: {
        renderMode: "richText" // the default render mode 'html' doesn't work with CSP configured with vite in dev env
      },
      series: [
        {
          type: 'sunburst',
          data: this.#withPercentages(data),
          radius: [0, '95%'],
          label: {
            minAngle: 4,
            formatter: (params) => {
              if(params.data.percent === undefined) {
                return "total"
              }
              return `${params.name} ${params.data?.percent?.toFixed(2)}%`
            }
          }
        }
      ]
    }
  }

  render(){
    this.chart.setOption(this.option)
  }

  resize() {
    this.chart.resize()
  }

  dispose(){
    this.chart.dispose()
  }

  #withPercentages(data) {
    let totalSum = 0
    const percentages = data.map((object) => {
      const sum = object.children.reduce(
        (acc, current) => acc + current.value,
        0
      )
      totalSum += sum

      return {
        name: object.name,
        value: object.value,
        total: sum,
        children: object.children.map((child) => {
          return {
            name: child.name,
            value: child.value,
            percent: (child.value / sum) * 100
          }
        })
      }
    });
    percentages.forEach((object) => {
      object.percent = (object.total / totalSum) * 100
    });

    return percentages
  }
}
