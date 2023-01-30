---
title: 组件开发技巧
date: 2022-04-24 06:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 1.基于组件库的八大设计原则

[Front end component design principles](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fsichenguo%2Fblog%2Ftree%2Fmaster%2Fsrc%2Ftranslation%2FFront%20end%20component%20design%20principles)

1) 层次结构和 UML 类图

2) 扁平化、面向数据的 state/props

3) 更加纯粹的 State 变化

4) 低耦合

5) 辅助代码分离

6) 提炼精华

7) 及时模块化

8) 集中/统一的状态管理

## 制定规范

规范的制定应该考虑css命名的统一，比如类库mint-ui样式前缀统一为mint-，iview的样式前缀统一为ivu-{componentname}。这样用户在解决样式覆盖等问题的时候，能够一目了然的知道是哪里出了问题。

另一个需要考虑的是组件对外暴露的方法名或者属性名的统一以及方法名传参顺序的一致性等，在方法和属性的命名上应该考虑兼容性，避免有歧义或者与原生属性冲突。比如有确定和取消按钮的组件，一些定义暴露的方法名为oncancel(instance,cb),onconfirm(instance,cb)

另外开发者在组件开发中不要炫技，不要过分设计，不要给用户预留彩蛋‘惊喜’，如果团队想给库增加feature，请给用户选择的权利，否则开源项目的信任度会大打折扣，参考antd企业级UI框架的圣诞节事件，HoHoHo~

回顾：今早一到公司，就发现群里有人说 antd 组件的样式变了，所有的`Button`组件都被加上了雪花，接着就看到 GitHub 上的 [issue](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fant-design%2Fant-design%2Fissues%2F13098)，几乎所有前端相关的群都在讨论这件事。

## 高内聚、低耦合及集中的数据管理

高内聚低耦合是判断设计好坏的标准，很多开发人员在组件封装过程中，设计的组件能够满足使用，但是组件的独立性不高，组件和组件之间的耦合性又不合理，当组件的使用场景变化时又得需要对组件进行改造。开发者在开发组件中应避免组件间相互依赖、共用状态等导致的逻辑理不清，糅合在一起形成一堆乱麻的情形。

举个栗子：

```
<!--公共蒙层-->
<r-popup v-model="visible" position="bottom" zIndex="900">
    <div class="r-birth-age_wrapper">
    <!--出生日期选择，操作区(取消、确认、tab切换)在组件内部封装，弹出动效单独处理-->
      <birthPicker
        :attrs="birthAttrsData"
        v-show="tabIndex == 0"
        @tabClick="tabClick"
        @onconfirm="birthConfirm"
        @change="birthChange"
        @cancel="cancel('birth')"
      ></birthPicker>
      <!--年龄选择，操作区(取消、确认、tab切换)在组件内部封装，弹出动效单独处理-->
      <agePicker
        :attrs="ageAttrsData"
        v-show="tabIndex == 1"
        @tabClick="tabClick"
        @confirm="ageConfirm"
        @cancel="cancel('age')"
        @change="ageChange"
      ></agePicker>
    </div>
  </r-popup>
  
  tabClick (index) {
      this.initbirthData = {
        value: this.birthAttrsData.value,
        text: this.birthAttrsData.text
      }
      this.initAgeData = {
        value: this.ageAttrsData.value,
        text: this.ageAttrsData.text
      }
      if (index === 0) {
        if (this.birthObj) {
          this.birthAttrsData.value = this.birthObj.value
          this.birthAttrsData.text = this.birthObj.text
        }
      } else {
        if (this.ageObj) {
          this.ageAttrsData.value = this.ageObj.value
          this.ageAttrsData.text = this.ageObj.text
        }
      }
      setTimeout(() => {
        this.tabIndex = index
      }, 0)
    },
cancel (type) {
      //重置列表选择数据为组件初始化数据
      if (this.tabIndex != this.initTabIndex) {
        if (type == 'birth' && this.tabIndex == 0 && this.initAgeData) {
          this.tabIndex = 1
          this.ageAttrsData.value = this.initAgeData.value
          this.ageAttrsData.text = this.initAgeData.text
        } else if (type == 'age' && this.tabIndex == 1 && this.initbirthData) {
          this.tabIndex = 0
          this.birthAttrsData.value = this.initbirthData.value
          this.birthAttrsData.text = this.initbirthData.text
        }
      }
     
        this.$emit('cancel')
          },
    birthChange (year, month, day) {
    //根据选择的出生日期，计算用户年龄，修改年龄数据
    ......
    this.ageObj = {
        value: `XXXX-01-01`,
        text: `Y周岁`
      }
    },
    ageChange (obj) {
        //根据选择的年龄计算，修改出生日期数据
      this.birthObj = {
        value: obj.value,
        text: obj.value
      }
    },
    birthConfirm (obj, val, el) {
        //浮层消失等操作后
        ......
        this.$emit('confirm', arguments[0].value, arguments[0].value)
    },
    ageConfirm () { 
    //浮层消失等操作后
    ......
        this.$emit('confirm', arguments[2].text, arguments[2].value)
    }

```

从dom结构和事件逻辑上看，两个子类型组件内部完成了各自逻辑封装，每个组件有自己的操作区和选择区，组件的初始化数据和暴露的事件也基本保持了一致。但是细看，会发现很多问题：

1）数据管理不集中：组件的数据可以分为初始化数据（未操作过的初始化数据或用户上次点击确认时暴露出的数据）、出生日期和年龄tab切换或滚动选择时的临时数据（只要不点击确认按钮，这份数据就一直保存用户当前操作值）、暴露出的数据（点击确认按钮后的数据露出）。原设计中数据是分开管理的，数据的状态分散在多个事件、多个变量中，当tab点击后，birthObj、ageOb及birthAttrsData、ageAttrsData相互作用，相互影响，如果其中一个数据计算出错，那么出生日期和年龄都存在不一致的可能性。

2）事件管理的不集中：组件的操作区放在了每个子类型组件中，子类型组件再通过事件往父组件进行事件传递，父组件中对子类型触发的事件处理函数是独立处理单个变量的，如果需要排查问题，那么需要在组件事件中层层排查，耗时耗力。

3）dom结构过于松散：组件的蒙层及动效分别放到了每个子类型组件中，操作区结构也很分散，dom的深度及复杂度就增加了。

改进后的代码设计：

dom结构： 蒙层和内容区合并、操作区整合、子类型组件事件统一、事件传参保持一致

改造后：

```
<div v-if="visible" class="r-birth-age-wrap">
    <div class="r-birth-age-cliper" ref="cliper" @touchmove.stop.prevent></div>
    <div class="r-birth-age-content" ref="content">
      <div class="r-birth-age-head">
        <div class="r-birth-age-head-cancel" @click="doCancel">取消</div>
        <ul class="r-birth-age-head-button">
          <li :class="{ active: tabIndex == 0 }" @click="tabClick(0)">出生日期</li>
          <li :class="{ active: tabIndex == 1 }" @click="tabClick(1)">年龄</li>
        </ul>
        <div class="r-birth-age-head-confirm" @click="doConfirm">确认</div>
      </div>
      <birthPicker
        v-if="tabIndex == 0"
        :attrs="birthAttrs"
        @input="doChange(...arguments, 0)"
      ></birthPicker>

      <agePicker
        class="r-birth-age-body"
        ref="agepicker"
        :slots="ageSlots"
        v-if="tabIndex == 1"
        @input="doChange(...arguments, 1)"
      ></agePicker>
    </div>
  </div>

tabClick(index) {
      //点击出生日期，把年龄的值带过来；点击年龄时，把出生日期对应的值带过来
      if (index == 0) {
        this.setBirthDate(this.valueMaps.birthValue)
      } else {
        this.setAgeSlots(this.valueMaps.ageValue)
      }
      this.$nextTick(() => {
        this.tabIndex = index
      })
    },
    doChange(param, tabIdx) {
      //生日
      if (tabIdx == 0) {
        //传参param为出生日期,如'2019-12-29'，进行年龄计算后，保存临时值
        ......
        this.valueMaps = {
          ageText,
          ageValue,
          birthText,
          birthValue
        }
      } else {
        //传参param为年龄值，如{text: '7周岁',value: '2013-01-01'}，取value做出生日期，保存临时值
        ......
        this.valueMaps = {
          ageText,
          ageValue,
          birthText，
          birthValue
        }
      }
    },
    doConfirm() {
      this.addCloseAnimation()
      ......
      this.visible = false
      this.$emit('confirm',Object.assign(this.valueMaps, {
              tabIndex: this.tabIndex
          })
      )
    },
    doCancel() {
      this.addCloseAnimation()
        this.visible = false
        this.$emit('cancel')
    }

```

## 辅助代码分离

组件库的组件经过合理粒度划分后，每个组件都包含代码（结构+样式+逻辑控制）、文档、例子、单元测试等内容

### **单元测试**

不管是常用的karma+mocha+chai进行的vue单元测试还是Jest+enzyme配合的react单元测试，其单元测试均须覆盖初始化组件、初始化组件的属性、访问组件的数据、调用组件的方法、组件的事件触发、组件内元素的查找等过程。以Vue单元测试为例，其核心是通过@vue/test-utils提供的方法，将组件进行实例化，对渲染后的html输出进行上述验证，以下一段代码示例Vue组件单元测试的各个过程。

```
import { mount } from '@vue/test-utils'

//组件：初始计数count为0，button点击后计数count+1的计数器
import Counter from './counter'   

describe('Counter', () => {
  // 组件初始化，可以传属性值propsData
  const wrapper = mount(Counter)

  // 组件渲染结果检验
  it('has a button', () => {
    expect(wrapper.contains('button')).toBe(true)
  })
  
  //模拟用户交互
  it('button click should increment the count', () => {
      //访问组件的数据
      expect(wrapper.vm.count).toBe(0)
      //组件内元素查找
      const button = wrapper.find('button')
      //组件的事件触发
      button.trigger('click')
      expect(wrapper.vm.count).toBe(1)
    })
})
```

### **文档的产出**

在组件库的开发过程中，开发者经常面对两个问题：

1）实例化组件以便于调试

2）为组件生成文档便于使用者了解组件的使用，文档内容包括了组件的引入、组件使用场景demo及源码、组件的[props、events、slots、methods]说明等。

### 打包发布及版本升级

组件库的发布过程比较简单，配置好package.json文件，执行npm publish即可。这里需要注意的是版本管理。

建议给发布脚本传版本参数，通过脚本修改package.json里version字段；如修改一些issues后进行的小的发版，次版本号或修正版本号需要改变，建议通过发布脚本先获取npm仓库中最新的版本号后，根据版本号递增规则，修改package.json里的version字段后发布。

# 2.组件编写一些注意点

## 理解 value 与 defaultValue

defaultValue 属性用于设置组件初始值，之后组件内部触发的值的改变，不会受到这个属性的影响，当父级组件触发 render 后，组件的值应当重新被赋予 defaultValue。

value 是受控属性，也用来设置值，但除了可以设置初始值（优先级比 defaultValue 高）之外，还应满足只要设置了 value，组件内部就无法修改状态的要求，这个组件的状态只能由父级授予并控制，所以叫受控属性。

value 与 defaultValue 不应该同时存在，最好做一下检查。

## render 函数中最小化代码逻辑

React 的宗旨是希望通过修改状态来修改渲染内容，尽量不要在 render 函数中编写过多的业务逻辑和判断语句，最好将能抽离成状态的放在 `state` 中，在 `componentWillReceiveProps` 中改变它

## [通用前端组件](https://juejin.cn/post/6844903847874265101#heading-4)

# 3.组件封装原则

## Vue的组件系统

Vue组件的API主要包含三部分：prop、event、slot

- [props](https://link.juejin.cn?target=https%3A%2F%2Fcn.vuejs.org%2Fv2%2Fguide%2Fcomponents-props.html) 表示组件接收的参数，最好用对象的写法，这样可以针对每个属性设置类型、默认值或自定义校验属性的值，此外还可以通过type、validator等方式对输入进行验证
- [slot](https://link.juejin.cn?target=https%3A%2F%2Fcn.vuejs.org%2Fv2%2Fguide%2Fcomponents-slots.html)可以给组件动态插入一些内容或组件，是实现高阶组件的重要途径；当需要多个插槽时，可以使用具名slot
- [event](https://link.juejin.cn?target=https%3A%2F%2Fcn.vuejs.org%2Fv2%2Fguide%2Fcomponents.html%23%E7%9B%91%E5%90%AC%E5%AD%90%E7%BB%84%E4%BB%B6%E4%BA%8B%E4%BB%B6)是子组件向父组件传递消息的重要途径

**单向数据流**

单向数据流是Vue组件一个非常明显的特征，不应该在子组件中直接修改props的值

- 如果传递的prop仅仅用作展示，不涉及修改，则在模板中直接使用即可
- 如果需要对prop的值进行转化然后展示，则应该使用computed计算属性
- 如果prop的值用作初始化，应该定义一个子组件的data属性并将prop作为其初始值

## 基本原则

1、单一原则：负责单一的页面渲染

2、多重职责：负责多重职责，获取数据，复用逻辑，页面渲染等

3、明确接受参数：必选，非必选，参数尽量设置以_开头，避免变量重复

4、可扩展：需求变动能够及时调整，不影响之前代码

5、代码逻辑清晰

6、封装的组件必须具有高性能，低耦合的特性

7、组件具有单一职责：封装业务组件或者基础组件，如果不能给这个组件起一个有意义的名字，证明这个组件承担的职责可能不够单一，需要继续抽组件，直到它可以是一个独立的组件即可。

## 维护性扩展性

1：活用组件继承
2：活用slot
3：使用props灵活表现界面元素
4：父子拆分

## 协作性

1：使用computed对props进行二次封装
2：css使用BEM命名
3：事件以handle开头
4：私有方法以_开头著名
5：对外暴露类似html空间的原生属性来贴近原生行为
6：常量使用const声明