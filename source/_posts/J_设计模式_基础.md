---
title: 0基础_设计模式
date: 2099-11-01 06:33:16
categories:
- J_设计模式
toc: true # 是否启用内容索引
---

# 概述

“设计模式”这个术语最初并不是出现在软件设计中，而是被用于建筑领域的设计中。

1977 年，美国著名建筑大师、加利福尼亚大学伯克利分校环境结构中心主任克里斯托夫·亚历山大（Christopher Alexander）在他的著作《建筑模式语言：城镇、建筑、构造（A Pattern Language: Towns Building Construction）中描述了一些常见的建筑设计问题，并提出了 253 种关于对城镇、邻里、住宅、花园和房间等进行设计的基本模式。

1995 年，艾瑞克·伽马（ErichGamma）、理査德·海尔姆（Richard Helm）、拉尔夫·约翰森（Ralph Johnson）、约翰·威利斯迪斯（John Vlissides）等 4 位作者合作出版了《设计模式：可复用面向对象软件的基础》，在软件开发领域里也以他们的“四人组”（Gang of Four，GoF）匿名著称。

## **软件设计模式的概念**

软件设计模式（Software Design Pattern），又称设计模式，是一套被**反复使用、分类编目、代码设计经验**的总结。其目的是为了提高代码的可**复用性、可读性和可靠性**。

设计模式的本质是面向对象设计原则的实际运用，是对类的**封装性、继承性和多态性**以及类的**关联关系和组合关系**的充分理解。

优点：

- 可以提高程序员的**思维**能力、**编程**能力和**设计**能力。
- 使程序设计更加**标准化**、代码编制更加**工程化**，使软件开发效率大大提高，从而缩短软件的开发周期。
- 使设计的代码可**复用性**高、**可读性**强、**可靠性**高、**灵活性**好、**可维护性**强。

## **基本要素**

1. 模式名称

每一个模式都有自己的名字，通常用一两个词来描述，可以根据模式的问题、特点、解决方案、功能和效果来命名。模式名称（PatternName）有助于我们理解和记忆该模式，也方便我们来讨论自己的设计。

2. 问题

问题（Problem）描述了该模式的应用环境，即何时使用该模式。它解释了设计问题和问题存在的前因后果，以及必须满足的一系列先决条件。

3. 解决方案

模式问题的解决方案（Solution）包括设计的组成成分、它们之间的相互关系及各自的职责和协作方式。因为模式就像一个模板，可应用于多种不同场合，所以解决方案并不描述一个特定而具体的设计或实现，而是提供设计问题的抽象描述和怎样用一个具有一般意义的元素组合（类或对象的 组合）来解决这个问题。

4. 效果

描述了模式的应用效果以及使用该模式应该权衡的问题，即模式的优缺点。主要是对时间和空间的衡量，以及该模式对系统的灵活性、扩充性、可移植性的影响，也考虑其实现问题。显式地列出这些效果（Consequence）对理解和评价这些模式有很大的帮助。

# **MV模式**

## **MVC模式**

- Model（模型）表示应用程序核心（如数据库）。
- View（视图）显示效果（HTML页面）。
- Controller（控制器）处理输入（业务逻辑）。

<img src="/img/image-20220514122304792.png" alt="image-20220514122304792" style="zoom:67%;" />

流程：

- View传送指令到Controller
- Controller完成业务逻辑后，要求Model改变状态
- Model将新的数据发送到View，用户得到反馈

## **MVP模式**

- 模型(Model)：提供数据
- 视图(View)：用户界面
- 表示器(Presenter)：逻辑的处理

<img src="/img/image-20220514122436666.png" alt="image-20220514122436666" style="zoom:67%;" />

流程：

- View与Model**无联系**，都通过Presenter传递
- View中**不部署任何业务逻辑** - 被动视图
- 所有逻辑都部署在Presenter

与MVC的区别，View不能直接从Model中读取数据

## **MVVM模式**-vue使用模式

- 模型(Model)：保存数据
- 视图(View)：用户界面
- 数据驱动(View-Model)：业务逻辑

<img src="/img/image-20220514122551211.png" alt="image-20220514122551211" style="zoom:67%;" />

流程：

- 操作View时，ViewModel感知变化，通知Model发生相应的变化，若Model改变时，ViewModel感知变化，通知View进行更新
- ViewModel与View双向数据绑定，Model通过接口请求数据交互，承上启下。

# GoF 的 23 种设计模式

**根据目的来分**

根据模式是用来完成什么工作来划分，这种方式可分为创建型模式、结构型模式和行为型模式 3 种。

1. 创建型模式：用于描述“怎样创建对象”，它的主要特点是“将对象的创建与使用分离”。GoF 中提供了单例、原型、工厂方法、抽象工厂、建造者等 5 种创建型模式。
2. 结构型模式：用于描述如何将类或对象按某种布局组成更大的结构，GoF 中提供了代理、适配器、桥接、装饰、外观、享元、组合等 7 种结构型模式。
3. 行为型模式：用于描述类或对象之间怎样相互协作共同完成单个对象都无法单独完成的任务，以及怎样分配职责。GoF 中提供了模板方法、策略、命令、职责链、状态、观察者、中介者、迭代器、访问者、备忘录、解释器等 11 种行为型模式。

 **根据作用范围来分**

根据模式是主要用于类上还是主要用于对象上来分，这种方式可分为类模式和对象模式两种。

1. 类模式：用于处理类与子类之间的关系，这些关系通过继承来建立，是静态的，在编译时刻便确定下来了。GoF中的工厂方法、（类）适配器、模板方法、解释器属于该模式。
2. 对象模式：用于处理对象之间的关系，这些关系可以通过组合或聚合来实现，在运行时刻是可以变化的，更具动态性。GoF 中除了以上 4 种，其他的都是对象模式。

**各个模式的功能**

1. **单例（Singleton）模式**：某个类只能生成一个实例，该类提供了一个全局访问点供外部获取该实例，其拓展是有限多例模式。
2. **原型（Prototype）模式**：将一个对象作为原型，通过对其进行复制而克隆出多个和原型类似的新实例。
3. 工厂方法（Factory Method）模式：定义一个用于创建产品的接口，由子类决定生产什么产品。
4. **抽象工厂（AbstractFactory）模式**：提供一个创建产品族的接口，其每个子类可以生产一系列相关的产品。
5. 建造者（Builder）模式：将一个复杂对象分解成多个相对简单的部分，然后根据不同需要分别创建它们，最后构建成该复杂对象。
6. **代理（Proxy）模式**：为某对象提供一种代理以控制对该对象的访问。即客户端通过代理间接地访问该对象，从而限制、增强或修改该对象的一些特性。
7. 适配器（Adapter）模式：将一个类的接口转换成客户希望的另外一个接口，使得原本由于接口不兼容而不能一起工作的那些类能一起工作。
8. 桥接（Bridge）模式：将抽象与实现分离，使它们可以独立变化。它是用组合关系代替继承关系来实现，从而降低了抽象和实现这两个可变维度的耦合度。
9. 装饰（Decorator）模式：动态的给对象增加一些职责，即增加其额外的功能。
10. 外观（Facade）模式：为多个复杂的子系统提供一个一致的接口，使这些子系统更加容易被访问。
11. 享元（Flyweight）模式：运用共享技术来有效地支持大量细粒度对象的复用。
12. 组合（Composite）模式：将对象组合成树状层次结构，使用户对单个对象和组合对象具有一致的访问性。
13. 模板方法（TemplateMethod）模式：定义一个操作中的算法骨架，而将算法的一些步骤延迟到子类中，使得子类可以不改变该算法结构的情况下重定义该算法的某些特定步骤。
14. 策略（Strategy）模式：定义了一系列算法，并将每个算法封装起来，使它们可以相互替换，且算法的改变不会影响使用算法的客户。
15. 命令（Command）模式：将一个请求封装为一个对象，使发出请求的责任和执行请求的责任分割开。
16. 职责链（Chain of Responsibility）模式：把请求从链中的一个对象传到下一个对象，直到请求被响应为止。通过这种方式去除对象之间的耦合。
17. 状态（State）模式：允许一个对象在其内部状态发生改变时改变其行为能力。
18. **观察者（Observer）模式**：多个对象间存在一对多关系，当一个对象发生改变时，把这种改变通知给其他多个对象，从而影响其他对象的行为。
19. 中介者（Mediator）模式：定义一个中介对象来简化原有对象之间的交互关系，降低系统中对象间的耦合度，使原有对象之间不必相互了解。
20. 迭代器（Iterator）模式：提供一种方法来顺序访问聚合对象中的一系列数据，而不暴露聚合对象的内部表示。
21. 访问者（Visitor）模式：在不改变集合元素的前提下，为一个集合中的每个元素提供多种访问方式，即每个元素有多个访问者对象访问。
22. 备忘录（Memento）模式：在不破坏封装性的前提下，获取并保存一个对象的内部状态，以便以后恢复它。
23. 解释器（Interpreter）模式：提供如何定义语言的文法，以及对语言句子的解释方法，即解释器。

# 五大设计原则

原则的目的只有一个：降低对象之间的耦合，增加程序的可复用性、可扩展性和可维护性。

核心五大原则：SOLID、DRY、KISS、YAGNI、LOD

### **SOLID**原则

- SRP(Single Responsibility Principle) 单一职责
- OCP(Open Closed Principle) 开闭原则
- LSP(Liskov Substitution Principle) 里氏替换
- ISO(Interface Segregation Principle) 接口隔离
- DIP(Dependency Inversion Principle) 依赖倒置/依赖反转

| 设计原则     | 一句话归纳                                                   | 目的                                       |
| ------------ | ------------------------------------------------------------ | ------------------------------------------ |
| 开闭原则     | 对扩展开放，对修改关闭                                       | 降低维护带来的新风险                       |
| 依赖倒置原则 | 高层不应该依赖低层，要面向接口编程                           | 更利于代码结构的升级扩展                   |
| 单一职责原则 | 一个类只干一件事，实现类要单一                               | 便于理解，提高代码的可读性                 |
| 接口隔离原则 | 一个接口只干一件事，接口要精简单一                           | 功能解耦，高聚合、低耦合                   |
| 迪米特法则   | 不该知道的不要知道，一个类应该保持对其它对象最少的了解，降低耦合度 | 只和朋友交流，不和陌生人说话，减少代码臃肿 |
| 里氏替换原则 | 不要破坏继承体系，子类重写方法功能发生改变，不应该影响父类方法的含义 | 防止继承泛滥                               |
| 合成复用原则 | 尽量使用组合或者聚合关系实现代码复用，少使用继承             | 降低代码耦合                               |

**一、SRP(Single Responsibility Principle) 单一职责**

定义：一个类或模块只负责完成一个功能

理解：不要设计大而全的类，要设计粒度小、高性能单一的类。该原则的目的是为了实现代码高内聚、低耦合、提高代码复用性、可读性以及可维护性。

补充：在保证单一职责时，要避免过分拆分，否则会降低内聚性，影响代码可维护性。

以下场景可能会出现类没有指责单一：

> - 类中的代码行数、函数、属性是否过多。可以考虑对该类进行拆分；
> - 类依赖的其他类过多，或者依赖类的其他类过多，不符合高内聚、低耦合的设计思想；
> - 私有方法过多，可以考虑将私有方法独立到新类中，设置为 public 方法，提高代码复用性；
> - 当发现类名比较难命名或类名笼统、冗长时，说明该类职责定义不够清晰；
> - 类中大量方法集中操作某几个属性时，可以考虑将这几个属性和方法拆分出去；

举例：

```
/**
* 如果下面的用户信息类仅在一个场景中使用，则没有什么问题；
* 如果后面用户的地址信息在其他模块中使用时，就可以将地址信息进行拆分。
* 以及各个属性的操作方法都要进行聚合到一个类中，提高代码的维护性。
*/
data class UserData(val userId:Long, 
                    val userName:String, 
                    val email:String,
                    val telephone:String,
                    val provinceOfAddress:String,
                    val cityOfAddress:String,
                    val regionOfAddress:String,
                    //.....其他属性
                   )
```

**二、OCP(Open Closed Principle) 开闭原则**

定义：(模块、类、方法)对拓展开放，对修改关闭。

理解：对于新功能尽量通过拓展已有代码而非修改的方式完成。

补充：在开发中不需要识别、预留所有拓展点，切勿过度设计。最合理的做法是，保证短期内、可确定的部分进行拓展设计。做常用的代码扩展性的方法：多态、依赖注入、基于接口开发，以及部分设计模式(装饰、策略、模板、责任链、状态等)

举例：

```
/**
* 基于接口开发。对于外部调用者，内部逻辑是无感知的，方便后面进行逻辑拓展，例如国内更新逻辑后面可能会支持跳转指定应用商店、H5链接等。
*/
interface IUpgradeService{
  fun checkUpgrade(ctx:Activity)
}

abstract class BaseUpgradeService : IUpgradeService{
  override fun checkUpgrade(ctx:Activity){
    //网络请求
    //....
    //执行需要更新
    startUpgrade()
  }
  
  fun startUpgrade()
}

class CnUpgradeService : BaseUpgradeService{
  override fun startUpgrade(){
    //国内执行更新逻辑。例如应用内下载安装等
  }
}

class I18nUpgradeService : BaseUpgradeService{
  override fun startUpgrade(){
    //海外执行更新逻辑。例如跳转google play
  }
}

//实际执行Activity
class MainActivity : AppCompactActivity{
  override fun onCreate(savedInstanceState : Bundle){
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    //执行更新逻辑
    ServiceLoader.instance.load(IUpgradeService::class.java).checkUpgrade(this)
  }
}
```

**三、LSP(Liskov Substitution Principle) 里氏替换**

定义：子类对象能够替换程序中父类对象出现的任何地方，并保证原来程序的逻辑行为不变及正确性不被破坏。

理解：在代码中可以用子类来替换父类，和多态类似，区别在于“里氏替换原则”是子类不能违背父类的协议，如父类要实现的功能、入参、出参、异常情况等。

举例：

```
/**
* 下面代码违反里氏替换原则。因为父类并没有对参数进行校验和抛异常，子类违背了父类的协议(入参判断、异常情况)。
*/
class UpgradeService{
  fun checkUpgrade(ctx: Activity, appId:Int, channelId:Int){
    //... 检查逻辑
  }
}

class CnUpgradeService : UpgradeService{
  override fun checkUpgrade(ctx: Activity, appId:Int, channelId:Int){
    if(appId == 0 || channelId == 0){
      throw Exception(...);
    }
    //...国内检测逻辑
  }
}
```

**四、ISO(Interface Segregation Principle) 接口隔离**

定义：客户端(接口调用者)不应该被强迫依赖它不需要的接口。

理解：与“单一职责”类似，区别在于“单一职责”针对的是模块、类、接口的设计，“接口隔离”一方面更侧重于接口的设计，另一方面思考的角度不同。

补充：这里的“接口”可以理解为：①一组API接口集合；②单个API接口或函数；③OOP中的接口概念

举例:

- 一组API接口集合

```
/**
* 下面代码违背了接口隔离原则。
* 因为后期新增的删除接口，对外所有服务都可以调用，非常容易导致误操作场景。
* 在没有做鉴权时，建议将删除接口单独做一个接口服务，供特殊场景使用。
*/
interface UserService{
  fun register(userName:String, password:String):Boolean
  fun login(userName:String, password:String):Boolean
  
  //后期新增了删除用户信息的接口
  fun deleteUserById(userId:Long):Boolean
}
```

- 单个API接口或函数

```
enum class ComputeType{
    ADD,
    SUBTRACT, 
    MULTIPLY , 
    DIVIDE
}

/**
* 假设下面代码每一种计算方式都比较复杂，则违背了接口隔离原则。
* 如果逻辑复杂的情况下，建议将每种情况作为一个单独的接口或函数进行处理。
* 例如:
* fun dataAdd(){}
* fun dataSubtract(){}
*/
fun dataCompute(firstNum:Int, secondNum:Int, computeType:ComputeType): Int{
  retrun when(computeType){
    ComputeType.ADD -> //....
    //....
  }
}
```

- OOP中的接口概念

```
/**
* 尽量避免设计大而全的接口，大而全会导致强迫调用者依赖不必要的接口
* 例如下面接口，如果调用者只是想配置监控和更新，还必须空实现配置日志数据。推荐根据功能进行拆分。
*/
interface IConfig{
  //更新配置信息
  fun update()
  //配置日志输出
  fun outputLog():String
  //配置监控
  fun monitorConfig()
}
```

**五、DIP(Dependency Inversion Principle) 依赖倒置/依赖反转**

定义：高层模块不依赖低层模块，它们共同依赖同一个抽象，抽象不要依赖具体实现细节，具体实现细节依赖抽象。

理解：该原则用于指导框架层面的设计，调用者与被调用者没有直接依赖关系，而是通过一个抽象(规范)来建立关系，同时抽象(规范)不依赖具体的调用者和被调用者的实现细节，而调用者和被调用者需要依赖抽象(规范)。例如，暴露请求参数，由调用者来实现具体的请求，并将结果再返回。

**控制反转(IOC)、依赖反转(DIP)、依赖注入(DI)的区别与联系**

- 控制反转：提供一个可拓展的代码骨架，用来组装对象、管理整个执行流程。不是一种具体的实现技巧，而是一种设计思想，一般用于指导框架层面的设计，具体的方式有很多，例如依赖注入、模板模式等。

```
abstract class TestCase{
  fun run(){
    if(doTest()){
      println("Test success")
    }else{
      println("Test failed")
    }
  }
  
  abstract fun doTest():Boolean
}

class UserServiceTest: TestCase{
  override doTest():Boolean{
    //....控制逻辑
  }
}

fun main(){
  UserServiceTest().run()
}
```

- 依赖注入：不通过 new()方式在类内部创建依赖类对象，而是将依赖的类对象在外部创建好后，通过构造函数、函数参数等方式传递(或注入)给类使用。

```
//Notification类使用通过构造函数传入的类对象messageSender调用发送逻辑
class Notification(val messageSender: MessageSender){
  fun sendMessage(cellphone: String, message: String){
    messageSender.send(cellphone, message)
  }
}

interface MessageSender{
  fun send(cellphone: String, message: String)
}

class SmsSender: MessgeSender{
  override fun send(cellphone: String, message: String){
    //...短信通知逻辑
  }
}

class EmailSender: MessageSender{
  override fun send(cellphone: String, message: String){
    //...邮件通知逻辑
  }
}

fun main(){
  val messageSender = SmsSender()
  val notification = Notification(messageSender)
  notification.sendMessage("xxxxx","xxxxx")
}
```

- 依赖反转：高层模块(调用者)不要依赖底层模块(被调用者代码)。高层模块和底层模块赢通过抽象来互相依赖。除此之外，抽象不要依赖具体实现细节，具体实现细节依赖抽象。

```
//抽象层
interface ISendTypeConfig{
    fun httpRequest(params: String)
    fun socketRequest(params: String)
}
//底层模块逻辑
class SendTypeManager(private val config: ISendTypeConfig){
    fun sendMessage(sendByHttp:Boolean, params: String){
        if (sendByHttp){
            config.httpRequest(params)
            return
        }
        //使用socket进行消息发送
    }
}

//高层模块逻辑
class SendTypeConfig: ISendTypeConfig{
    override fun httpRequest(params: String) {
        //使用http请求
    }

    override fun socketRequest(params: String) {
        //使用socket请求
    }

}

fun main(){
    //这段代码属于[底层模块]逻辑。高层模块只需关注消息发送方式的具体实现，然后调用底层模块的发送消息即可，不会关注底层模块的具体实现。
    SendTypeManager(SendTypeConfig()).sendMessage(true, "这是一条http发送的消息")
}
```

### DRY原则

(Don't Repeat Yourself)原则，不要重复自己

理解：不要开发重复代码，可以复用或提取公共代码，同时也要注意遵守“单一职责”和“接口隔离”原则。

提升代码复用性的方法：

- 减少代码耦合
- 满足单一职责原则
- 模块化
- 业务与非业务逻辑分离
- 通用代码下沉
- 继承、抽象、多态、封装
- 应用模板等设计模式

### KISS原则

(Keep It Simple And Stupid)原则

理解：尽量保证代码简洁，使用通用技术(同事都懂的技术)、不重复造轮子、不过度优化。

举例：对于某个数值的提取或者匹配判断，使用正则表达式可以使代码行数更少，看似更简单，但其实并不是所有同事都熟悉正则表达式，而且在编写正则规则时易出现bug，所以可以采用通用技术来实现。

### YAGNI原则

(You Aint't Gonna Need It)原则，你不会用到它的

理解：不去设计与开发当前功能用不到的代码，但并不意味着不考虑拓展性，可以预留好拓展点，后面需要时再开发。

举例：目前项目只对国内市场，未来将会面向国内海外同时使用。所以在开发中不需要提前编写海外部分代码，但是在国内海外有差异的逻辑上要预留好拓展点，方便后面对海外逻辑进行补充。

### LOD原则/迪米特法则

(Law of Demeter)原则/迪米特法则

理解：不该有直接依赖关系的类之间，不要有依赖；有依赖关系的类之间，尽量只依赖必要的接口。

举例：

```
/**
* NetworkTransporter 类负责底层网络通信，根据请求获取数据。
*
* 该类的入参类型为 HtmlRequest 对象，作为底层类，应保证通用性，而不是仅服务于下载HTML。所以违反了迪米特法则，依赖了不该有直接依赖的 HtmlRequest 类。
*/
public class NetworkTransporter {
    // 省略属性和其他方法...
    public Byte[] send(HtmlRequest htmlRequest) {
      //...
    }
}

public class HtmlDownloader {
  private NetworkTransporter transporter;//通过构造函数或IOC注入
  
  public Html downloadHtml(String url) {
    Byte[] rawHtml = transporter.send(new HtmlRequest(url));
    return new Html(rawHtml);
  }
}

/**
* Document 表示网页文档，后续的网页内容抽取、分词、索引都是以此为处理对象。
*
* 该类总有如下3个问题:
* 1. 构造函数中的 downloader.downloadHtml() 逻辑复杂，耗时长，不应该放到构造函数中，会影响代码的可测试性。
* 2. HtmlDownloader 对象在构造函数中通过 new 来创建，违反了基于接口而非实现编程的设计思想，也会影响到代码的可测试性。
* 3. 从业务含义上来讲，Document 网页文档没必要依赖 HtmlDownloader 类，违背了迪米特法则。
*/
public class Document {
  private Html html;
  private String url;
  
  public Document(String url) {
    this.url = url;
    HtmlDownloader downloader = new HtmlDownloader();
    this.html = downloader.downloadHtml(url);
  }
  //...
}
```

