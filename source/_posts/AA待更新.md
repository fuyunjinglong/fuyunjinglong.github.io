







# 信息获取-阅读-处理

**前言**

**知识的层级**可分为[资料](https://zh.wikipedia.org/wiki/资料)、[资讯](https://zh.wikipedia.org/wiki/資訊)、[知识](https://zh.wikipedia.org/wiki/知识)及[智慧](https://zh.wikipedia.org/wiki/智慧)四个阶段，

知识的形成则是透过收集一些资料，再从资料中找出有用的资讯，利用这些资讯加上自己的想法及做法，最后产生出知识。

智慧则是以知识为基础加上个人的应用能力并将其运用于生活上。

举例来说，我们制做一份报告时，会先收集大量的资料，再从这堆资料中找出可以运用在报告的资讯，运用自己的想法和做法去完成报告，当你完成这份报告后，从报告中所学习到的东西便会转化成自己的知识。

把个人及群体得到的知识进行有效管理，则是知识管理最根本的目的。

## 获取

**信息分类**

- **即时信息：**主要指各种即时资讯，以短讯形式出现的信息。
- **社交信息**：在社交媒体上关注或者订阅的人提供的信息。比如，微信公众号、微博、推特、即刻。
- **工作信息**：在工作中遇到、需要进行留存 / 处理的信息。
- **深度信息**：一些需要深度阅读，满足自我提升等需求的信息。比如，来自少数派、财新周刊的内容。

**工具**

- 搜索引擎：百度搜索、谷歌搜索、必应搜索、雅虎搜索

- 聚合搜索导航：虫部落-快搜、医学导航、设计导航等

- 被动收取：RSS 订阅(pc推荐google插件feedbro+rsshub,app推荐NetNewWire)、邮件订阅

**操作**

- 早上：微信公众号，比如每日早报、新华社· 早知天下事、人民日报·新闻早班车、每日资讯简报、财经早餐、Wind 资讯
- 接着：今日趋势APP和今日热榜APP

**优质信息源推荐**

## 阅读

**工具**

- 简悦

## 处理

**工具**

- notion：黑鲸知识库
- 印象笔记：标签知识库

# 面试

## 谈薪

- 先出价者输

**先出价者输**

切记不要先出价，这也是HR会直接问你期望薪资的原因，泄露低价就会被对方处处拿捏。你可以装糊涂，看我的演技。哎呀，我好久没出来面试了，咱们也是第一家，我也不太清楚现在是啥行情呀，咱们这个岗位的薪资范围是多少呀。或者是直接反问，咱们这个岗位的薪酬结构，年终奖股票，工作强度等细节，以及岗位薪资的范围。

这样就有两种结局：一个是HR会给你一个薪资范围，我们直接基于这个数字来判断是否符合预期。第二个是HR也是个老司机，也一样打太极回来，那就没办法了。

首先你得知道你到底值多少钱，这个数字你说了不算，市场说了算。我建议大家每个季度没事就面试几次，不吐工作，就图和面试官学习技术 外加上和HR谈谈钱，你就时刻知道自己的身价，然后加上你合理的涨幅，在高出10%左右的留给对方砍价，报出去也是可以的。

如果对方爽快答应，直接入职，如果不合理，也不要怂，直接礼貌且坚定的告诉对方，我很认可贵公司的发展前景，但是现在这个offer的薪资和我的预期还是有一些差距，看能否给到XX呢，我个人的发展方向和这个岗位的匹配度非常高，我相信入职以后我也一定能够带来符合这个薪资的作用，或者是你有其他特殊的优势，比如如果是Vue岗位，你给Vue贡献过代码等等

还有很多其他的谈判原则，比如坚决不接收对方的第一次开价，以降价换取成交是条走向灭亡之路,学会装作意外和不情愿，要防止红鲱鱼糖衣炮弹的攻击等等技巧，大家感兴趣可以去读这两本书

## 互联网公司黑名单

[程序员找工作黑名单](https://github.com/shengxinjing/programmer-job-blacklist)

# 通用命名规范

## 命名规则

默认规则是camelCase(小驼峰)

PascalCase(大驼峰): 各个单次首字母大写

camelCase(小驼峰)：首个单词首字母小写，其余单词首字母大写

**命名实践如下：**

- **目录或项目命名**：全小写，连接符(-, _)，如/project-athena
- **组件名**：大驼峰，如KeepLive.vue
- **js,ts文件名**：小驼峰
- **class命名**
  - 基于姓氏命名法（继承 + 外来），modulename，modulename_info，modulename_info_user
  - 嵌套层次最多3层，超过3层或名字过长，新开作用区间，取缩写miu_tit，miu_tit_co
- **变量**：小驼峰
  - 布尔类型：需要有含义的前缀，比如`has, is, wether, can, should`等，如isVisited
  - 数组复数：需要标识复数的结尾，比如s或list
- **函数**：小驼峰
- **常量**：全大写，连接符(_)，如MAX_IMAGE_SIZE 
- 注释：单行用//,多行用/**/

**前缀含义如下：**

| 动词 | 含义                            | 返回值                                                |
| ---- | ------------------------------- | ----------------------------------------------------- |
| can  | 判断是否可执行某个动作 ( 权限 ) | 函数返回一个布尔值。true：可执行；false：不可执行     |
| has  | 判断是否含有某个值              | 函数返回一个布尔值。true：含有此值；false：不含有此值 |
| is   | 判断是否为某个值                | 函数返回一个布尔值。true：为某个值；false：不为某个值 |
| get  | 获取某个值                      | 函数返回一个非布尔值                                  |
| set  | 设置某个值                      | 无返回值、返回是否设置成功或者返回链式对象            |

## 参考

[阿里前端命名规范](https://developer.aliyun.com/article/850913#slide-1)

[不要在sass嵌套过深](http://mydearxym.github.io/2016/09/22/not-nest-in-sass/)

[sass的ClassName命名](https://guide.aotu.io/docs/name/classname.html)

# 代码规范

## 拒绝屎山代码

- TypeScript不要用成AnyScript
- 代码不要太长
- 组件和方法解耦
- 使用 `Mutable Data`响应式数据
- 多用魔术字符串即枚举
- 多尝试不同的方式来解决相同的问题

**TypeScript不要用成AnyScript**

> 如果充分发挥 `AnyScript` 的宗旨，意味着你很轻松地就让代码增加了 `30%` 毫无用处但也挑不出啥毛病的代码，这些代码甚至还会增加项目的编译时间（毕竟增加了`ts`校验和移除的成本嘛）

**代码不要太长**

> 单文件不超过400行，函数不超过100行

**组件和方法解耦**

> 组件优先使用pros和emit,回避vuex

**使用 `Mutable Data`响应式数据**

> 只需要三个单词：`Watch`、`Watch`、`Watch`

**多用魔术字符串即枚举**

```
enum EventType {
  Move,
  Skip,
  Batch
}
```

**多尝试不同的方式来解决相同的问题**

比如vue不只有template，还有render

# inject/provide的响应式问题

官方说法： **provide/inject** 的 **直接绑定数据** 才不支持响应式，但又因为 **没有对数据的进行深层次处理**，所以原有的响应式数据才会继续触发整个响应式系统的改变。

说人话：直接修改对象，inject监听不到改动；修改对象的某个属性，就能监听到改动。加一句，即使修改属性，computed也监听不到变化。

看源码:关闭了依赖数据的 响应式依赖收集;但对inject注入对象的深层处理，没有屏蔽响应式

```
export function initInjections(vm: Component) {
  // 对inject注入对象深层处理，没有屏蔽响应式
  const result = resolveInject(vm.$options.inject, vm)
  if (result) {
  // 关闭了依赖数据的 响应式依赖收集
    toggleObserving(false)
    Object.keys(result).forEach(key => {
      if (__DEV__) {
        defineReactive(vm, key, result[key], () => warn(''))
      } else {
        defineReactive(vm, key, result[key])
      }
    })
    toggleObserving(true)
  }
}
export function resolveInject(inject: any, vm: Component): Record<string, any> | undefined | null {
  if (inject) {
    const result = Object.create(null)
    const keys = hasSymbol ? Reflect.ownKeys(inject) : Object.keys(inject)

    for (let i = 0; i < keys.length; i++) {
      const key = keys[i]
      if (key === '__ob__') continue
      const provideKey = inject[key].from
      if (provideKey in vm._provided) {
        result[key] = vm._provided[provideKey]
      } else if ('default' in inject[key]) {
        const provideDefault = inject[key].default
        result[key] = isFunction(provideDefault) ? provideDefault.call(vm) : provideDefault
      } else if (__DEV__) {
        warn('')
      }
    }
    return result
  }
}
```

**参考**

[Vue 2 阅读理解（十四）之 Provide/Inject 依赖注入](https://juejin.cn/post/7135761522759827493)

# 设计模式

## 设计原则

核心五大原则：SOLID、DRY、KISS、YAGNI、LOD

### **SOLID**原则

- SRP(Single Responsibility Principle) 单一职责
- OCP(Open Closed Principle) 开闭原则
- LSP(Liskov Substitution Principle) 里氏替换
- ISO(Interface Segregation Principle) 接口隔离
- DIP(Dependency Inversion Principle) 依赖倒置/依赖反转

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

# 反对Vue2升级到Vue3

最近一篇反对**Vue2**升级到**Vue3**的文章在vue官方社区引起了热议。（原文链接：[Vue 3 was a mistake that we should not repeat](https://link.juejin.cn/?target=https%3A%2F%2Fmedium.com%2Fjs-dojo%2Fvue-3-was-a-mistake-that-we-should-not-repeat-81cc65484954)）

原作者主要的问题，是从Vue3**突破性**的改变以及**周边生态圈**未能及时跟上的角度，重点强调了迁移升级**成本**+**风险**较大。

关于升级成本问题：尤大也承认了**Vue3**升级体验并没有想象中的那么流畅，**Vue4**会吸取经验，做好平稳迭代。

**一、破坏性的api变更（Breaking changes）**

**[Events API](https://link.juejin.cn?target=https%3A%2F%2Fv3-migration.vuejs.org%2Fbreaking-changes%2Fevents-api.html)的弃用让这个问题首当其冲**。Vue实例再也不能作为**事件总线**做事件通信，`$`on，`$`off，`$`once的彻底**移除**意味着之前所有有关代码都必须重新推翻重写，虽然有很好的插件工具让这件事变得没那么复杂，但是仍然会带来不小的迁移成本。

**代码构建问题。** 你会经常遇到用Vue2写法写出来的代码在**构建(build)** 失败或抛出**警告**。因为这些api写法在Vue3中已经被废弃。这问题在已存在的大型项目中的尤为突出下图展示了一部分**Breaking changes**，可以看到破坏性的api变更数确实很多：

**二、颠覆式的设计模式（composition-api）**

颠覆式的**composition-api**慢慢向**面向函数**思想转变，导致很多原有习惯于**options-api**的开发者反感Vue正在像react靠拢，没有坚持住Vue特色。它提出了一种新的基于函数的 Vue 组件编写方式，引起了Vue社区大量的争议和分裂，甚至将社区分隔为两种观点阵营针锋相对，最终导致了[Vue 最黑暗的一天事件](https://link.juejin.cn?target=https%3A%2F%2Fdev.to%2Fdanielelkington%2Fvue-s-darkest-day-3fgh)。这很令人沮丧。

**三、生态系统（The ecosystem）**

生态系统和框架本身一样重要。因为没有**责任机制**，在有争议的决定和在弃用功能的时候，很多框架周边的生态系统的许多贡献者会被迫**离开**，并导致许多库被**放弃**或者**延迟更新**。很多时候，我们没有办法做版本兼容时，我们往往只能把责任归咎于，开源库缺乏**同理心**和对大局的理解。

**四、文档系统（Documentation）**

在我们的日常开发中，尤其是在使用框架时，我们会遇到各种各样的问题，这时我们时常需要**google**或者**问答社区**作为帮手，但是目前关于**Vue**搜索出来的结果几乎全是Vue2的结果

**五、过往案例（The past）**

过渡到 Vue 3 看起来很像从*AngularJS*过渡到*Angular*（*版本 1⇒ 2*）。大量的延迟和重大更改导致了挫败感，最终 Angular 失去了对 React 和 Vue 的吸引力。

**尤大的回复：**

> 1.当我们进行版本切换时，所有核心库和工具都与这两个版本兼容（或为 Vue 2/3 支持提供单独的版本）。
>
> 实际上阻碍升级的依赖都是第三方，主要是 **Nuxt** 和 **Vuetify**。
>
> 2.实际使用过 Composition API + < script setup> 的用户在真是开发中的反馈非常积极，证明这是一个有价值的补充，现在他们中的许多人更喜欢它而不是 Options API。
>
> 我们当然可以更好地处理新 API 的引入，但仅仅因为存在争议，并不意味着它是错误的或者不必要的。实际上，引入大的、新的想法的行为，势必会让那些喜欢呆在舒适区的人感到不安，但如果我们迎合这种心态，就永远不会取得真正的进展。
>
> 3、4.虽然我们确实创造了 Vue CLI、Vuex、Vetur 和 VuePress 的新替代品，但它们本身都有适用于 Vue 3 的版本。
>
> 5.关于和angular的过往对比：
>
> - 没有可比性，不能拿Vue升级和angularjs -> angular做对比。
>
> - Angular 和 AngularJS 是根本不同的框架。几乎没有共享交集，除了完全重写之外没有实际的迁移路径。
>
> - 有许多生产 Vue 2 应用程序成功迁移到 Vue 3 的案例。很容易吗，确实不是，但是他们都迁移成功了。
>
> 6.我们同意，Vue3升级体验并没有想象中的那么流畅。Vue 将随着吸取的经验不断发展，我们绝对不打算在未来的Vue4中，进行这样的破坏性重大升级。

**参考**

[Vue2升级到Vue3到底是不是一个正确的选择？(尤雨溪亲自回复解读)](https://juejin.cn/post/7117525259212816414#heading-1)

# Vue2和Vue3比较

## Option API和Composition API

**vue2 Option API**

```vue
<template>
  <div>
    <p>{{ person.name }}</p>
    <p>{{ car.name }}</p>
  </div>
</template>

<script>
export default {
  name: "Person",

  data() {
    return {
      person: {
        name: "小明",
        sex: "male",
      },
      car: {
        name: "宝马",
        price: "40w",
      }
    };
  },

  watch:{
      'person.name': (value) => {
          console.log(`名字被修改了, 修改为 ${value}`)
      },
      'person.sex': (value) => {
          console.log(`性别被修改了, 修改为 ${value}`)
      }
  },

  methods: {
    changePersonName() {
      this.person.name = "小浪";
    },

    changeCarPrice() {
      this.car.price = "80w";
    }
  },
};
</script>
```

**vue3 Composition API**

```vue
<template>
  <p>{{ person.name }}</p>
  <p>{{ car.name }}</p>
</template>

<script lang="ts" setup>
import { reactive, watch } from "vue";

// person的逻辑
const person = reactive<{ name: string; sex: string }>({
  name: "小明",
  sex: "male",
});
watch(
  () => [person.name, person.sex],
  ([nameVal, sexVal]) => {
    console.log(`名字被修改了, 修改为 ${nameVal}`);
    console.log(`名字被修改了, 修改为 ${sexVal}`);
  }
);
function changePersonName() {
  person.name = "小浪";
}

// car的逻辑
const car = reactive<{ name: string; price: string }>({
  name: "宝马",
  price: "40w",
});
function changeCarPrice() {
  car.price = "80w";
}
</script>
```

# Vue高效代码

- 多用Array.includes()
- 提前退出/提前返回。如果不使用，可能有多层if
- 用字面量替代switch,如用obj的属性取值替代switch

**提前退出/提前返回**

```
a({type}={})=>{
 if(!type) return 'no type';
 if(type==='dog') return 'is dog';
 return type
}
```

# this用法

**this经典面试题**

```
  // 谁调用我，我就指向谁
  var name = 222
  var a={
    name:111,
    say:function(){
      console.log(this.name);
    }
  }
  var fun = a.say
  fun() // fun.call(window)
  a.say() // a.say.call(a)

  var b={
    name:333,
    say:function(fn){
      fn(); // fn.call(window),难点
    }
  }
  b.say(a.say) // 相当于把函数当进去执行，这种函数作为入参的，都是指向全局window，所以就是fn.call(window)
  b.say=a.say

  b.say() // b.say.call(b)
```

# github优秀仓库

**后端**

- [JavaGuide](https://github.com/Snailclimb/JavaGuide)
- [CS-Notes](https://github.com/CyC2018/CS-Notes)
- [advanced-java](https://github.com/doocs/advanced-java)
- [JCSprout](https://github.com/crossoverJie/JCSprout)
- [technology-talk](https://github.com/aalansehaiyang/technology-talk)
- [fullstack-tutorial](https://github.com/frank-lam/fullstack-tutorial)
- [3y](https://github.com/ZhongFuCheng3y/3y)
- [java-bible](https://github.com/biezhi/java-bible)
- [interviews](https://github.com/kdn251/interviews/blob/master/README-zh-cn.md)
- 

**算法**

- [LeetCodeAnimation](https://github.com/MisterBooo/LeetCodeAnimation)
- [awesome-java-leetcode](https://github.com/Blankj/awesome-java-leetcode)
- [leetcode](https://github.com/azl397985856/leetcode)
- [瓶子君](https://www.pzijun.cn/blog/)
- [GitHub上最火的、最值得前端学习的数据结构与算法项目](https://github.com/FrontEndGitHub/FrontEndGitHub/issues/2)
- [awesome-coding-js算法](https://github.com/ConardLi/awesome-coding-js)

# 面试清单

[一行命令爬取掘金文章榜单](https://github.com/shfshanyue/blog/blob/master/post/juejin-interview.md)

[github更多面试题](https://github.com/search?o=desc&p=1&q=%E5%89%8D%E7%AB%AF%E9%9D%A2%E8%AF%95&s=&type=Repositories)

[FrontEndGitHub-前端尤其Issues](https://github.com/FrontEndGitHub/FrontEndGitHub)

[Front-end-Developer-Questions-前端面试问题](https://h5bp.org/Front-end-Developer-Interview-Questions/translations/chinese/#js-questions)

[Daily-Question-大厂每日一题](https://q.shanyue.tech/)

[CS-Interview-Knowledge-Map-前端进阶之道](https://github.com/InterviewMap/CS-Interview-Knowledge-Map)

[Daily-Interview-Question-木易杨前端进阶](https://muyiy.cn/question/)

[fe-interview-大前端面试宝典](https://lucifer.ren/fe-interview/#/)

[fe-interview-前端硬核面试](https://github.com/biaochenxuying/blog/blob/master/interview/fe-interview.md#js-%E7%BB%8F%E5%85%B8%E9%9D%A2%E8%AF%95%E7%9F%A5%E8%AF%86%E6%96%87%E7%AB%A0)

[fe-interview-前端知识每日3+1](http://www.h-camel.com/index.html)

[node-interview-饿了么大前端](https://github.com/ElemeFE/node-interview/tree/master/sections/zh-cn)

[Front-End-Interview-Notebook-前端复习笔记](https://github.com/CavsZhouyou/Front-End-Interview-Notebook)

[FE-Interview-前端面试星球](https://github.com/lgwebdream/FE-Interview)

[javascript-guidebook-JavaScript知识图谱](https://tsejx.github.io/javascript-guidebook/basic-concept)

[前端收集图谱](https://github.com/foru17/front-end-collect)

[阿秀的学习笔记](https://github.com/forthespada/InterviewGuide)

[前端进阶之旅](https://github.com/poetries)

[冰雨博客](https://bingyu123.gitee.io/blog/web/base/html/)

[前端那些事](https://jonny-wei.github.io/blog/base/)

[进击的大前端](http://www.dennisgo.cn/Articles/Engineering/leader.html)

[前端系统进阶](https://interview.poetries.top/fe-blog-docs/blog-docs/javascript/-Ajax%E6%80%BB%E7%BB%93%E7%AF%87.html)

[前端九部-入门指南](https://www.yuque.com/fe9/basic/cg6wui)

[前端语音社群](https://github.com/febobo/web-interview)

[阿离王](https://github.com/347830076/)

[前端自我修养](https://fe.mbear.top/)

[maqixiang的学习](http://study.maqixiang.com/blog/20201026.html)

[TeqNG](https://www.teqng.com/homev1/)

[Nealyang-一个优秀的前端都应该阅读这些文章](https://github.com/Nealyang/PersonalBlog/issues/48)

**其他更精彩**

[2020 - 2021 年 Web 前端最新导航](https://segmentfault.com/a/1190000033134496)

[GitHub 上能挖矿的神仙技巧 - 如何发现优秀开源项目](https://github.com/biaochenxuying/blog/issues/45)

[恕我直言，你可能连 GitHub 搜索都不会用 - 如何精准搜索的神仙技巧](https://github.com/FrontEndGitHub/FrontEndGitHub/issues/4)

# Resume

## 准备阶段

### 简历

**个人信息**

- 冷熊/男/1990
- 本科/北极大学计算机系
- 工作年限：3年
- 微博：[@Easy](http://weibo.com/easy) （如果没有技术相关内容，也可以不放）
- 技术博客：http://old.ftqq.com ( 使用GitHub Host的Big较高 )
- Github：http://github.com/easychen ( 有原创repo的Github帐号会极大的提升你的个人品牌 )
- 期望职位：web高级程序员

主要技术栈：React技术栈、Rax、weex、Kissy、Flutter、Koa、Midway、Ts 等等

涉及领域：pc 页面、手机客户端（目前主要是手淘）、Flutter（FlutterGo 主开发者）、研究性项目后台开发等

**项目经历**

a项目(2022.6-2023.1)

**工作经历**

**开源项目**

**项目层次**

- PC: toC 项目，主要为重客户端状态较为复杂的项目，以前端主要形态为卖点的产品，比如文档类，表格类，API调试类，思维导图类，笔记类。可将该类项目放在首位。另外，还有电商类、股票类等。或者官网。

- RN(react native)/Electron/Browser-Extension: 手机应用、桌面应用、浏览器插件等跨端能力

- Mobile/小程序: 移动端 Web 项目

- Admin: 后台管理系统

- Node: BFF 类项目，或者 Node.js 的纯后端项目

- Infra: 在公司内部所做的基础建设，比如 Package 的发包，组件库的建设，脚手架的编写，公司公共能力抽象为私有库之类。甚至是 lint/type 等 dot 文件的规则建立

**注意点**

- 过时技术栈不要写，比如 jQuery/Bootstrap
- 项目难点，项目亮点，合并集中描述
- 不要写和自己工作经验不符的内容，比如工作五年了，简历还都是熟悉 HTML，CSS 
- 了解、熟悉、掌握、精通四个等级，一般不建议写精通
- 不要光秃秃地写一句“熟悉数据结构与算法”,比如我熟悉十大排序中的快排、归并、堆排

**级别**

- 初级：基础的编码能力和思维
- 中级：熟练使用基础，独立完成任务
- 高级:通过封装、优化手段，提升小组效率
- 资深高级：工程化
- 专家:大前端体系架构

## 投递阶段

### **分2阶段**

- 试水阶段，投递其它城市岗位此时可一周面试一到两次，在面试中完善八股文以及简历，用时三周左右。脱产者可一周面试两到三次。若有 offer，可选择价高者接收一个，方便为正式面试议价。

  一定要投可线上面试的公司

  一定不要投中大厂，容易弄花简历

- 正式阶段，投递心仪公司岗位，或托人内推。此时态度要虚心，诚恳，提前花费一个小时了解其公司（或业务线）业务、商业模式、产品形态，以及公司所需的技术栈等。在 Boss 直聘或邮件投递简历时，可发表一些对技术栈匹配，业务感兴趣且强烈加入的意愿。

**邮件投递**

> 尊敬的米哈游公司人力资源部：
>
> 我是一个热爱米哈游游戏的前端工程师，特别喜欢原神这款游戏，已经玩了两年。在这两年里，我对原神的设计、游戏体验、以及技术实现等方面有了深入的了解，对这款游戏充满了热爱和敬仰。
>
> 因此，我强烈想加入米哈游公司，一起打造更好的原神。我相信，我的专业知识和技能可以为米哈游公司的发展做出贡献，同时，我也期待能够在这里得到成长和提高。
>
> 我拥有丰富的游戏开发经验，熟悉游戏引擎、美术设计、以及游戏编程等方面的技能。我对游戏设计和开发有着独特的见解，并能够灵活地运用到实际工作中。同时，我也具备出色的团队合作精神和良好的沟通能力，可以与团队成员高效协作，完成共同的目标。
>
> 如果米哈游公司有合适的职位空缺，我表示愿意投递我的简历并参加面试。随附的附件中包含了我的详细简历和作品集，希望能给您带来更多的了解。如果需要更多的信息或证明，我随时准备提供。
>
> 我对加入米哈游公司充满了热忱和期待，相信我能够成为您们团队中的一员，为原神的发展做出更多的贡献。
>
> 谢谢您的耐心阅读，期待您的回复。
>
> 此致 敬礼！
>
> 山月

## 面试阶段

不要裸辞 不要裸辞 不要裸辞

### 面试时间

1. 公司会议室面试。不过对心理素质要求极高。
2. **约到晚八点面试**。可早点下班在家中面试，如家里较远无法赶回去，可在公司会议室面试。甚至订一个公司附近的钟点房，进行面试。

### **离职原因**

年终季度奖全部取消，公司业务停滞，无上升空间，于是主动出来，并放弃 N+1，来寻求更好的机会。

### 自我介绍

时间1-3min,准备几个亮点，不要背简历

> 1. 自己的经历和优势。
> 2. 自己做过的项目中的难点，怎么思考和解决的。
> 3. 自己的重大业绩，突破性成果，包括工作和学习。
> 4. 对面试的公司的理解和认识，如果有独特的理解肯定会加分。
> 5. 比赛成绩，国内排名，开源项目。

# 移动端

## 基础

**跨平台、跨端**

- 跨平台：指跨操作系统
- 跨端：指跨web,ios,android,iot设备

# 前端工程化

按照项目的生命周期来分配：

- 需求评审：技术选型
- 开发前：统一规范
- 开发中：模块化、组件化
- 开发完：测试
- 编译：构建工具
- 部署：自动化部署
- 上线后：性能监控
- 发现问题：性能优化
- 项目迭代：重构
- 项目巨型化：微服务
- 无服务架构升级：Serverless 

## 技术选型

- 可控性
- 稳定性
- 适用性
- 易用性

**可控性**

可控，就是指如果这门技术因为 BUG 对项目造成了影响，团队中有人能够解决它，而不是等待官方修复。作为技术团队的负责人，一定要是能够兜底的那个人。如果团队解决不了，你必须能够解决。比如魔改vue,react

**稳定性**

稳定性，表示一门技术更新迭代比较稳定，不会有特别大的修改，比较靠谱。即使有，也很容易做到向后兼容（迁移简单、成本小）。

有两个很典型的反例，那就是 Angular 和 python。例如 python2 升级到 python3，除了语法、API 不兼容之外，python3 的各个版本之间也有差异，直到现在才逐渐稳定下来。

稳定性判断：

> 1. 社区是否活跃、配套插件是否丰富。
> 2. 是否经常维护，可以通过 git commit 查看。
> 3. 官方文档是否齐全。
> 4. 更新是稳定、小步的迭代，而不是非常激进的更新。

**适用性**

适用性，是指需要根据业务场景和团队成员来选择技术。

适用性判断：

> 1. 业务的生命周期：短期js，长期推荐ts
> 2. 业务的兼容性：ios,android，iot,不能有死机、白屏、卡顿
> 3. 团队成员：选择约束性比较强的技术是一个更好的选择，如ts(不会就去学)。要用长远的眼光来为团队考虑，太过自由的技术，往往会造成灾难。

**易用性**

学习曲线相对平缓，而不是陡峭的

## 统一规范

- 代码规范
- git规范
- 项目规范
- UI规范

**代码规范**

- 代码格式
- 命名规范
- 文档注释

出名的js规范：

> - [airbnb (101k star 英文版)](https://github.com/airbnb/javascript)，[airbnb-中文版](https://github.com/lin-123/javascript)
> - [standard (24.5k star) 中文版](https://github.com/standard/standard/blob/master/docs/README-zhcn.md)
> - [百度前端编码规范 3.9k star](https://github.com/ecomfe/spec)

出名的css规范：

> - [styleguide 2.3k star](https://github.com/fex-team/styleguide/blob/master/css.md)
> - [spec 3.9k star](https://github.com/ecomfe/spec/blob/master/css-style-guide.md)

**git规范**

- 分支管理规范
- git commit规范

**项目规范**

- npm管理
- pnpm管理

**UI规范**

- 统一命名
- 统一样式

## 模块化、组件化

- 高内聚 低耦合
- 模块化、组件化
- Web Components

**高内聚 低耦合**

高内聚：一个函数尽量只做一件事，如注册模块，只处理注册逻辑

低耦合：两个模块之间的关联程度低，如注册模块调用其他模块，直接引用其他模块即可，不要直接在注册模块中写其他功能

**模块化、组件化**

模块化：拆分html,css,js，按照功能拆分模块

组件化：按照功能拆分为各个组件

**Web Components**

目前三大框架在构建工具下可很好实现组件化，但如果自己实现呢？

组件化是前端未来的发展方向，[Web Components ](https://developer.mozilla.org/zh-CN/docs/Web/Web_Components)就是浏览器原生支持的组件化标准。使用 Web Components API，浏览器可以在不引入第三方代码的情况下实现组件化。

## 测试

原则：程序简单，不用测试代码；功能越复杂，越需要测试代码(如果修改一个复杂项目，你要对所有功能都点击一遍，但有了测试代码，一条命令执行就行)

- 单元测试Unit
- 集成测试Integration
- 端到端测试E2E

## 构建工具

- webpack
- rollup
- vite

## 自动化部署

- Gitea + Jenkins
- Github Actions

## 性能监控

- 事前预警
- 事后分析

**数据上报**

- [sendBeacon](https://developer.mozilla.org/zh-CN/docs/Web/API/Navigator/sendBeacon)
- [XMLHttpRequest](https://developer.mozilla.org/zh-CN/docs/Web/API/XMLHttpRequest)
- image

## 性能优化

- 加载时优化
- 运行时优化

**加载时优化**

- 白屏时间
- 首屏时间

**运行时优化**

## 重构

**定义**

《重构2》定义：

> 所谓重构（refactoring）是这样一个过程：在不改变代码外在行为的前提下，对代码做出修改，以改进程序的内部结构。重构是一种经千锤百炼形成的有条不紊的程序整理方法，可以最大限度地减小整理过程中引入错误的概率。本质上说，重构就是在代码写好之后改进它的设计。

重构和性能优化都在不改变程序功能的情况下修改代码

- 重构：为了让代码变得更加容易理解、易于修改
- 性能优化：为了让程序运行得更快

**重构的原则**

1. 事不过三，三则重构。即不能重复写同样的代码，在这种情况下要去重构。
2. 如果一段代码让人很难看懂，那就该考虑重构了。
3. 如果已经理解了代码，但是非常繁琐或者不够好，也可以重构。
4. 过长的函数，需要重构。
5. 一个函数最好对应一个功能，如果一个函数被塞入多个功能，那就要对它进行重构了。（4 和 5 不冲突）
6. 重构的关键在于运用大量微小且保持软件行为的步骤，一步步达成大规模的修改。每个单独的重构要么很小，要么由若干小步骤组合而成。

**重构手法**

在[《重构2》](https://book.douban.com/subject/30468597/)这本书中介绍了上百种方法，其中8种比较常用：

1. 提取重复代码，封装成函数
2. 拆分功能太多的函数
3. 变量/函数改名
4. 替换算法
5. 以函数调用取代内联代码
6. 移动语句
7. 折分嵌套条件表达式
8. 将查询函数和修改函数分离



## 微服务

- 小应用，建议还是单独建一个项目开发
- 大应用，使用微前端可以减少开发维护成本

## Serverless 

**定义**

无服务架构。是指由第三方云计算供应商以服务的方式为开发者提供所需功能，例如数据库、消息，以及身份验证等。它的核心思想是让开发者专注构建和运行应用，而无需管理服务器。

优点：

> - 自动扩展伸缩、无需自己管理

缺点：

> - 云上访问速度变得比较慢

**分类**

- Faas(Function as a Service) 函数即服务
- Baas(Backend as a Service) 后端即服务

Faas 其实是一个云计算平台，用户可以将自己写的函数托管到平台上运行。而 Baas 则是提供一系列的服务给用户运用，用户通过 API 调用。

**Faas**

定义

> 一个函数通常用于处理某种业务逻辑，例如一个 `abs()` 函数，它将返回所传参数的绝对值。我们可以把这个函数托管到 Faas 平台，由平台提供容器并运行这个函数。当执行函数时，只需要提供函数所需的参数，就可以在不部署应用的情况下得到函数的执行结果。

**Baas**

定义

> 假设你是一个前端，现在要开发一个网站。前端部分你可以自己完成，但后端部分怎么办呢？这个时候就可以使用 Baas 了。也就是说，你只需编写和维护前端页面。其他的一切，例如数据库、身份验证、对象存储等等都由云服务商提供。你只需要在前端通过 API 调用它们就可以使用所需的服务。

**参考**

[带你入门前端工程化](https://woai3c.github.io/introduction-to-front-end-engineering/12.html#faas)

# Typora常用用法

```
1.代码段
{% codeblock %}
{% endcodeblock %}

2.图片
{% img /img/20200302_1_9.png  "imgPIC'alt text'" %}

3.加粗
**加粗**

4.链接
{% link 深入理解分布式事务 http://wwwe/distributed-transaction.html [external] [title] %}

5.点点
- 风格1
- 风格2

6.换行符
末尾两个空格表示换行

7.本地图片使用服务器绝对路径
C:\Users\fuyunjinglong\AppData\Roaming\Typora\typora-user-images\
/img/

8.竖线段落
使用>回车即可
```



