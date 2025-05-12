import * as echarts from 'echarts/core';
import {
  TitleComponent,
  TooltipComponent,
  LegendComponent
} from 'echarts/components';
import { PieChart as PieChart_} from 'echarts/charts';
import { LabelLayout } from 'echarts/features';
import { CanvasRenderer } from 'echarts/renderers';
import { GraphicComponent } from 'echarts/components';

echarts.use([
  TitleComponent,
  TooltipComponent,
  LegendComponent,
  PieChart_,
  CanvasRenderer,
  LabelLayout,
  GraphicComponent
]);


export class PieChart {

  constructor(
    {
      element,
      data = [],
      theme = 'dark',
      dataId = 0,
      onSeriesClick = () => {},
      title = '',
      goBackText = '',
    }
   ){

    this.title = title,
    this.goBackText = goBackText;
    this.dataId = dataId;
     // this is used for navigation in the chart
     this.optionsStack = [];
     this.allOptions = {};
     this.allOptions[dataId] = this.#optionConfig({dataId: dataId, data: data});

     this.chart = echarts.init(element, theme);

     this.chart.on("click", 'series', (params) => {
       onSeriesClick(params, this.optionsStack.length);
     });
   }

  render(option = {}) {
    let newOption;
    if (Object.keys(option).length === 0) {
      newOption = this.allOptions[this.dataId];
    } else {
      newOption = option;
    }
    this.chart.setOption(newOption);
  }

  resize() {
    this.chart.resize()
  }

  dispose(){
    this.chart.dispose()
  }

  goForward(seriesId, data) {
    this.optionsStack.push(this.#currentOptionId());
    this.allOptions[seriesId] = this.#optionConfig({dataId: seriesId, data: data});
    this.render(this.allOptions[seriesId])
  }

  goBack() {
    if (this.optionsStack.length === 0) {
      return
    }

    this.render(this.allOptions[this.optionsStack.pop()]);
  }

  #currentOptionId() {
    const optionId = this.chart.getOption();
    if(optionId === null) { return null }

    return this.chart.getOption().id
  }

  #optionConfig({ dataId, data }) {
    const goBackText = this.optionsStack.length === 0 ?  '' : this.goBackText;

    return {
      id: dataId,
      title: {
        text:  this.title,
      },
      tooltip: {
        trigger: 'item'
      },
      legend: {
        orient: 'vertical',
        left: 'left'
      },
      tooltip: {
        renderMode: "richText" // the default render mode 'html' doesn't work with CSP configured with vite in dev env
      },
      graphic: [
        {
          type: 'text',
          left: 10,
          bottom: 10,
          style: {
            text: goBackText,
            fontSize: 18,
            fill: 'grey'
          },
          onclick: () => {
            this.goBack()
          }
        }
      ],
      series: this.#pieSeriesConfig(data),
      legend: { show: false }
    };
  }

  #pieSeriesConfig(data) {
    return  [
     {
       type: 'pie',
       radius: '50%',
       data: data,
       emphasis: {
         itemStyle: {
           shadowBlur: 10,
           shadowOffsetX: 0,
           shadowColor: 'rgba(0, 0, 0, 0.5)'
         }
       },
       label: {
        formatter: '{b} {d}%',
        overflow: 'break',
       }
     }
   ]
 }
}
