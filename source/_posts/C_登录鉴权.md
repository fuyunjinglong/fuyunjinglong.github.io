---
title: C_登录鉴权
date: 2022-05-13 06:33:16
categories:
- C_框架及工具
toc: true # 是否启用内容索引
---

# 0.cookie,sessionStorage,localStorage

| 特性         | cookie                                                       | sessionStorage | localStorage               | session                                           |
| ------------ | ------------------------------------------------------------ | -------------- | -------------------------- | ------------------------------------------------- |
| 来源         | 服务端设置到客户端，客户端保存。服务端响应头set-cookie保存sid,请求头携带sid访问服务器 | 会话中存在     | 除非手动删除，否则一直存在 | 服务端                                            |
| 大小         | 4k                                                           | 5M             | 5M                         |                                                   |
| 与服务器交互 | 同源的http请求中携带                                         |                |                            |                                                   |
| 类型         | 会话cookie(随会话产生和丢失)和过期cookie(随过期时间)         |                |                            |                                                   |
| 场景         | 非重要信息                                                   | 用户登录信息   |                            |                                                   |
| 安全性       | 容易被窃取，采用session-cookie认证鉴权                       |                |                            |                                                   |
| 特点         | 存在客户端，不可跨域                                         |                |                            | **SessionID 是连接 Cookie 和 Session 的一道桥梁** |

# 1.**登录鉴权的3种方式**

[前端鉴权（Cookie/Session、Token和OAuth）原文](https://juejin.cn/post/6844903864458543111#heading-0)

1. session-cookie
2. Token 验证(JWT)
3. OAuth(开放授权)

## session-cookie

**cookie**

  Http协议是一个无状态的协议，服务器不会知道到底是哪一台浏览器访问了它，因此需要一个标识用来让服务器区分不同的浏览器。cookie就是这个管理服务器与客户端之间状态的标识。
  cookie的原理是，浏览器第一次向服务器发送请求时，服务器在response头部设置Set-Cookie字段，浏览器收到响应就会设置cookie并存储，在下一次该浏览器向服务器发送请求时，就会在request头部自动带上Cookie字段，服务器端收到该cookie用以区分不同的浏览器。当然，这个cookie与某个用户的对应关系应该在第一次访问时就存在服务器端，这时就需要session了。

**session**

  session是会话的意思，浏览器第一次访问服务端，服务端就会创建一次会话，在会话中保存标识该浏览器的信息。它与cookie的区别就是session是缓存在服务端的，cookie 则是缓存在客户端，他们都由服务端生成，为了弥补Http协议无状态的缺陷。

**session-cookie认证**

1. 服务器在接受客户端首次访问时在服务器端创建seesion，然后保存seesion(我们可以将seesion保存在 内存中，也可以保存在redis中，推荐使用后者)，然后给这个session生成一个唯一的标识字符串,然后在 响应头中种下这个唯一标识字符串。
2. 签名。这一步通过秘钥对sid进行签名处理，避免客户端修改sid。(非必需步骤)
3. 浏览器中收到请求响应的时候会解析响应头，然后将sid保存在本地cookie中，浏览器在下次http请求的 请求头中会带上该域名下的cookie信息。
4. 服务器在接受客户端请求时会去解析请求头cookie中的sid，然后根据这个sid去找服务器端保存的该客 户端的session，然后判断该请求是否合法。

<img src="/img/image-20220602070007978.png" alt="image-20220602070007978" style="zoom:67%;" />

**用户登录认证**

  使用session-cookie做登录认证时，登录时存储session，退出登录时删除session，而其他的需要登录后才能操作的接口需要提前验证是否存在session，存在才能跳转页面，不存在则回到登录页面。
  在koa中做一个验证的中间件，在需要验证的接口中使用该中间件。

## Token 验证(JWT)

<img src="/img/image-20220602070819745.png" alt="image-20220602070819745" style="zoom:80%;" />

 token是一个令牌，浏览器第一次访问服务端时会签发一张令牌，之后浏览器每次携带这张令牌访问服务端就会认证该令牌是否有效，只要服务端可以解密该令牌，就说明请求是合法的，令牌中包含的用户信息还可以区分不同身份的用户。一般token由用户信息、时间戳和由hash算法加密的签名构成。

**阮一峰老师的 [JSON Web Token 入门教程](https://link.juejin.cn/?target=http%3A%2F%2Fwww.ruanyifeng.com%2Fblog%2F2018%2F07%2Fjson_web_token-tutorial.html) 讲的非常通俗易懂**

**Token认证流程**

1. 客户端使用用户名跟密码请求登录
2. 服务端收到请求，去验证用户名与密码
3. 验证成功后，服务端会签发一个 Token，再把这个 Token 发送给客户端
4. 客户端收到 Token 以后可以把它存储起来，比如放在 Cookie 里或者 Local Storage 里
5. 客户端每次向服务端请求资源的时候需要带着服务端签发的 Token
6. 服务端收到请求，然后去验证客户端请求里面带着的 Token（request头部添加Authorization），如果验证成功，就向客户端返回请求的数据，如果不成功返回401错误码，鉴权失败。

**Token和session的区别**

1. session-cookie的缺点：（1）认证方式局限于在浏览器中使用，cookie是浏览器端的机制，如果在app端就无法使用cookie。（2）为了满足全局一致性，我们最好把session存储在redis中做持久化，而在分布式环境下，我们可能需要在每个服务器上都备份，占用了大量的存储空间。（3）在不是Https协议下使用cookie，容易受到CSRF跨站点请求伪造攻击。
2. token的缺点：（1）加密解密消耗使得token认证比session-cookie更消耗性能。（2）token比sessionId大，更占带宽。
3. 两者对比，它们的区别显而易见：（1）token认证不局限于cookie，这样就使得这种认证方式可以支持多种客户端，而不仅是浏览器。且不受同源策略的影响。（2）不使用cookie就可以规避CSRF攻击。（3）token不需要存储，token中已包含了用户信息，服务器端变成无状态，服务器端只需要根据定义的规则校验这个token是否合法就行。这也使得token 的可扩展性更强。

**JWT（JSON Web Token）**

  JWT 的原理是，服务器认证以后，生成一个 JSON 对象，这个JSON对象肯定不能裸传给用户，那谁都可以篡改这个对象发送请求。因此这个JSON对象会被服务器端签名加密后返回给用户，返回的内容就是一张令牌，以后用户每次访问服务器端就带着这张令牌。
  这个JSON对象可能包含的内容就是用户的信息，用户的身份以及令牌的过期时间。

**JWT的组成部分**

  在该网站[JWT](https://link.juejin.cn?target=https%3A%2F%2Fjwt.io)，可以解码或编码一个JWT。一个JWT形如：

<img src="/img/image-20220602070206100.png" alt="image-20220602070206100" style="zoom:80%;" />

它由三部分组成：Header（头部）、Payload（负载）、Signature（签名）。



1. Header部分是一个JSON对象，描述JWT的元数据。一般描述信息为该Token的加密算法以及Token的类型。`{"alg": "HS256","typ": "JWT"}`的意思就是，该token使用HS256加密，token类型是JWT。这个部分基本相当于明文，它将这个JSON对象做了一个Base64转码，变成一个字符串。Base64编码解码是有算法的，解码过程是可逆的。头部信息默认携带着两个字段。
2. Payload 部分也是一个 JSON 对象，用来存放实际需要传递的数据。有7个官方字段，还可以在这个部分定义私有字段。一般存放用户名、用户身份以及一些JWT的描述字段。它也只是做了一个Base64编码，因此肯定不能在其中存放秘密信息，比如说登录密码之类的。
3. Signature是对前面两个部分的签名，防止数据篡改，如果前面两段信息被人修改了发送给服务器端，此时服务器端是可利用签名来验证信息的正确性的。签名需要密钥，密钥是服务器端保存的，用户不知道。算出签名以后，把 Header、Payload、Signature 三个部分拼成一个字符串，每个部分之间用"点"（.）分隔，就可以返回给用户。

**JWT的特点**

1. JWT 默认是不加密，但也是可以加密的。生成原始 Token 以后，可以用密钥再加密一次。
2. JWT 不加密的情况下，不能将秘密数据写入 JWT。
3. JWT 不仅可以用于认证，也可以用于交换信息。有效使用 JWT，可以降低服务器查询数据库的次数。
4. JWT 的最大缺点是，由于服务器不保存 session 状态，因此无法在使用过程中废止某个 token，或者更改 token 的权限。也就是说，一旦 JWT 签发了，在到期之前就会始终有效，除非服务器部署额外的逻辑。
5. JWT 本身包含了认证信息，一旦泄露，任何人都可以获得该令牌的所有权限。为了减少盗用，JWT 的有效期应该设置得比较短。对于一些比较重要的权限，使用时应该再次对用户进行认证。
6. 为了减少盗用，JWT 不应该使用 HTTP 协议明码传输，要使用 HTTPS 协议传输。

**JWT验证用户登录**

```
//前端代码
//axios的请求拦截器，在每个request请求头上加JWT认证信息
axios.interceptors.request.use(
    config => {
        const token = window.localStorage.getItem("token");
        if (token) {
        // 判断是否存在token，如果存在的话，则每个http header都加上token
        // Bearer是JWT的认证头部信息
            config.headers.common["Authorization"] = "Bearer " + token;
        }
        return config;
    },
    err => {
        return Promise.reject(err);
    }
);
//登录方法：在将后端返回的JWT存入localStorage
async login() {
    const res = await axios.post("/login-token", {
        username: this.username,
        password: this.password
    });
    localStorage.setItem("token", res.data.token);
},
//登出方法：删除JWT
async logout() {
    localStorage.removeItem("token");
},
async getUser() {
    await axios.get("/getUser-token");
}
```

## OAuth

  三方登入主要基于OAuth 2.0。OAuth协议为用户资源的授权提供了一个安全的、开放而又简易的标 准。与以往的授权方式不同之处是OAuth的授权不会使第三方触及到用户的帐号信息(如用户名与密码)， 即第三方无需使用用户的用户名与密码就可以申请获得该用户资源的授权，因此OAuth是安全的。我们常见的提供OAuth认证服务的厂商有支付宝、QQ、微信。这样的授权方式使得用户使用门槛低，可以更好的推广自己的应用。
  OAuth相关文章推荐阮一峰老师的一系列文章[OAuth 2.0 ](https://link.juejin.cn?target=http%3A%2F%2Fwww.ruanyifeng.com%2Fblog%2F2019%2F04%2Foauth_design.html)。

**OAuth认证流程**

  OAuth就是一种授权机制。数据的所有者告诉系统，同意授权第三方应用进入系统，获取这些数据。系统从而产生一个短期的进入令牌（token），用来代替密码，供第三方应用使用。
  OAuth有四种获取令牌的方式，不管哪一种授权方式，第三方应用申请令牌之前，都必须先到系统备案，说明自己的身份，然后会拿到两个身份识别码：客户端 ID（client ID）和客户端密钥（client secret）。这是为了防止令牌被滥用，没有备案过的第三方应用，是不会拿到令牌的。
  在前后端分离的情境下，我们常使用授权码方式，指的是第三方应用先申请一个授权码，然后再用该码获取令牌。

**GitHub第三方登录示例**

  我们用例子来理清授权码方式的流程。

1. 在GitHub中备案第三方应用，拿到属于它的客户端ID和客户端密钥。

  在github-settings-developer settings中创建一个OAuth App。并填写相关内容。填写完成后Github会给你一个客户端ID和客户端密钥。

2. 此时在你的第三方网站就可以提供一个Github登录链接，用户点击该链接后会跳转到Github。这一步拿着客户端ID向Github请求授权码code。
3. 用户跳转到Github，输入Github的用户名密码，表示用户同意使用Github身份登录第三方网站。此时就会带着授权码code跳回第三方网站。跳回的地址在创建该OAuth时已经设置好了。`http://localhost:3000/github/callback`
4. 第三方网站收到授权码，就可以拿着授权码、客户端ID和客户端密钥去向Github请求access_token令牌。
5. Github收到请求，向第三方网站颁发令牌。
6. 第三方网站收到令牌，就可以暂时拥有Github一些请求的权限，比如说拿到用户信息，拿到这个用户信息之后就可以构建自己第三方网站的token，做相关的鉴权操作。

## 注意事项

**使用 cookie 时需要考虑的问题**

- 因为存储在客户端，容易被客户端篡改，使用前需要验证合法性
- 不要存储敏感数据，比如用户密码，账户余额
- 使用 httpOnly 在一定程度上提高安全性
- 尽量减少 cookie 的体积，能存储的数据量不能超过 4kb
- 设置正确的 domain 和 path，减少数据传输
- **cookie 无法跨域**
- 一个浏览器针对一个网站最多存 20 个Cookie，浏览器一般只允许存放 300 个Cookie
- **移动端对 cookie 的支持不是很好，而 session 需要基于 cookie 实现，所以移动端常用的是 token**



**使用 session 时需要考虑的问题**

- 将 session 存储在服务器里面，当用户同时在线量比较多时，这些 session 会占据较多的内存，需要在服务端定期的去清理过期的 session
- 当网站采用**集群部署**的时候，会遇到多台 web 服务器之间如何做 session 共享的问题。因为 session 是由单个服务器创建的，但是处理用户请求的服务器不一定是那个创建 session 的服务器，那么该服务器就无法拿到之前已经放入到 session 中的登录凭证之类的信息了。
- 当多个应用要共享 session 时，除了以上问题，还会遇到跨域问题，因为不同的应用可能部署的主机不一样，需要在各个应用做好 cookie 跨域的处理。
- **sessionId 是存储在 cookie 中的，假如浏览器禁止 cookie 或不支持 cookie 怎么办？** 一般会把 sessionId 跟在 url 参数后面即重写 url，所以 session 不一定非得需要靠 cookie 实现
- **移动端对 cookie 的支持不是很好，而 session 需要基于 cookie 实现，所以移动端常用的是 token**



**使用 token 时需要考虑的问题**

- 如果你认为用数据库来存储 token 会导致查询时间太长，可以选择放在内存当中。比如 redis 很适合你对 token 查询的需求。
- **token 完全由应用管理，所以它可以避开同源策略**
- **token 可以避免 CSRF 攻击(因为不需要 cookie 了)**
- **移动端对 cookie 的支持不是很好，而 session 需要基于 cookie 实现，所以移动端常用的是 token**



**使用 JWT 时需要考虑的问题**

- 因为 JWT 并不依赖 Cookie 的，所以你可以使用任何域名提供你的 API 服务而不需要担心跨域资源共享问题（CORS）
- JWT 默认是不加密，但也是可以加密的。生成原始 Token 以后，可以用密钥再加密一次。
- JWT 不加密的情况下，不能将秘密数据写入 JWT。
- JWT 不仅可以用于认证，也可以用于交换信息。有效使用 JWT，可以降低服务器查询数据库的次数。
- JWT 最大的优势是服务器不再需要存储 Session，使得服务器认证鉴权业务可以方便扩展。但这也是 JWT 最大的缺点：由于服务器不需要存储 Session 状态，因此使用过程中无法废弃某个 Token 或者更改 Token 的权限。也就是说一旦 JWT 签发了，到期之前就会始终有效，除非服务器部署额外的逻辑。
- JWT 本身包含了认证信息，一旦泄露，任何人都可以获得该令牌的所有权限。为了减少盗用，JWT的有效期应该设置得比较短。对于一些比较重要的权限，使用时应该再次对用户进行认证。
- JWT 适合一次性的命令认证，颁发一个有效期极短的 JWT，即使暴露了危险也很小，由于每次操作都会生成新的 JWT，因此也没必要保存 JWT，真正实现无状态。
- 为了减少盗用，JWT 不应该使用 HTTP 协议明码传输，要使用 HTTPS 协议传输。



**使用加密算法时需要考虑的问题**

- 绝不要以**明文存储**密码
- **永远使用 哈希算法 来处理密码，绝不要使用 Base64 或其他编码方式来存储密码，这和以明文存储密码是一样的，使用哈希，而不要使用编码**。编码以及加密，都是双向的过程，而密码是保密的，应该只被它的所有者知道， 这个过程必须是单向的。哈希正是用于做这个的，从来没有解哈希这种说法， 但是编码就存在解码，加密就存在解密。
- 绝不要使用弱哈希或已被破解的哈希算法，像 MD5 或 SHA1 ，只使用强密码哈希算法。
- 绝不要以明文形式显示或发送密码，即使是对密码的所有者也应该这样。如果你需要 “忘记密码” 的功能，可以随机生成一个新的 **一次性的**（这点很重要）密码，然后把这个密码发送给用户。

# 2.**单点登录3种方案（SSO）**

单点登录（Single Sign On，简称 SSO），是指在多系统应用群中登录一个系统，便可在其他所有系统中得到授权，无需再次登录。

这种技术目前得到了广泛使用，它核心解决了一个问题：用户只需要登录一次，就可以访问所有相互信任的应用系统。

1. Cookies、Session 同步
2. 分布式 Session 方式
3. 统一认证授权方式

## Cookies、Session 同步

**基于 Cookie 的单点登录**

基于 Cookie 的单点登录是最简单的单点登录实现方式，它使用 Cookie 作为媒介，存放用户凭证。

用户登录父应用之后，应用返回一个加密的 Cookie，用户访问子应用的时候，携带上这个 Cookie，授权应用解密 Cookie 并进行校验，校验通过则登录当前用户。

这种方式虽然实现简单，但 Cookie 不够安全，容易泄漏，且不能跨域实现免登。

## 分布式 Session 方式

分布式 Session 实现单点登录原理是将用户认证信息保存于 Session 中，即以 Session 内存储的值为用户凭证，一般采用 Cache 中间件实现（如 Redis）。用户再次登录时，应用服务端获取分布式 Session 来校验用户信息。如图所示：

<img src="/img/image-20220602072359920.png" alt="image-20220602072359920" style="zoom:50%;" />

一般情况下都是基于 Redis 实现 Session 共享，将 Session 存储于 Redis 上，然后将整个系统的全局 Cookie Domain 设置于顶级域名上，这样 SessionID 就能在各个子系统间共享。

这种方式也有一个问题，共享 Session 无法处理跨顶级域名。

## 统一认证授权

<img src="/img/image-20220602072505173.png" alt="image-20220602072505173" style="zoom: 80%;" />

由图可知，通过统一认证授权方式实现单点登录，需要有一个独立的认证系统。

用户第一次访问应用系统时，由于还未登录，被引导到认证系统中进行登录，认证系统接受用户名密码等安全信息，生成访问令牌（ticket）。用户通过 ticket 访问应用系统，应用系统接受到请求之后会访问认证系统检查 ticket 的合法性，如果检查通过，用户就可以在不用再次登录的情况下访问应用系统资源。

## 实际应用

**1.使用 JWT 实现单点登录**

JWT （JSON Web Token）是一个开放标准（RFC7519），它是一个含签名并携带用户相关信息的加密串。页面请求校验登录接口时，请求头中携带 JWT 串到后端服务，后端通过签名加密串匹配校验，保证信息未被篡改，校验通过则认为是可靠的请求，将正常返回数据。

DataSimba（奇点云数据中台产品）结合 JWT 与分布式 session，实现多域多空间单点登录。通过 JWT 生成和校验令牌，将刷新令牌存储在 redis 中，网关统一校验令牌，校验通过后将用户信息设置在请求头中，应用在拦截器中获取到用户信息后即可验证通过。

不同域中的 DataSimba 共用一套密钥并且实时同步用户信息，通过 JWT 生成和校验令牌，用户登录其中一个域后，前端获取 JWT 加密串并存储在 Local Storage 中，当用户切换到其他域时前端传入加密串，后端网关校验，由此实现免登录访问其他域资源，如下图所示：

<img src="/img/image-20220602072615066.png" alt="image-20220602072615066" style="zoom:80%;" />

**2.使用 OAuth2.0 实现单点登录**

OAuth 2.0 是一种认证授权机制，主要用来颁发令牌（token），OAuth 的核心就是向第三方应用颁发令牌，OAuth2.0 就是对应上文 2.3（统一认证授权方式实现单点登录）中的认证系统。

OAuth 在“客户端”与“服务端”之间，设置了一个授权层（Authorization Layer）, “客户端”通过登录授权层获取令牌，通过令牌即可访问服务端资源。

OAuth2.0 单点登录流程同上文介绍的“统一认证授权方式”流程一致：用户首次访问服务端资源时未登录，被引导到认证系统中进行登录授权，登录成功后获取令牌，用户获取令牌后可以通过令牌获取用户信息。客户端必须获取到用户授权，才能获取令牌。

OAuth2.0 定义了 4 种授权方式：

```
授权码模式（authorization code）
简化模式（implicit）
密码模式（resource owner password credentials）
客户端模式（client credentials）
```

<img src="/img/image-20220602072721885.png" alt="image-20220602072721885" style="zoom:80%;" />

**3.集成 LDAP 实现统一认证登录**

LDAP（Lightweight Directory Access Protocol），它是基于 X.500 标准的轻量级目录访问协议。LDAP 目录服务是由目录数据库和一套访问协议组成的系统。

日常办公经常会有多套系统，如果各个系统各自维护一套用户认证，用户需要记住多个用户名密码。系统各自管理用户认证的方式，不但会有重复建设的问题，用户体验也会差——经常会有用户忘记密码的情况。通过 LDAP，我们可以管理企业级账号，认证用户名密码，实现统一账号登录，只需一个用户名密码就可以登录所有系统。

<img src="/img/image-20220602072800696.png" alt="image-20220602072800696" style="zoom:80%;" />

LDAP 主要是用来实现统一身份认证的技术，目前市面上大部分的开源系统都支持 LDAP，因此通过 LDAP 能够统一管理和维护公司的账号，极大地提高了运维的工作效率。

# 3.**关于购物车数据**

当用户登录状态时，添加产品到购物时，查看Basket中是否有Status为True的购物车，没有则添加一条新的Basket记录，并将产品信息相关数据添加至BasketDetail表中。
当用户未登录时，使用cookie记录一个BasketId值，不往Basket表中插入数据，只往BasketDetail插入数据，其中的BasketId值使用cookie中的BasketId值，当用户登录后，查看Basket中是否有Status为True的购物车记录，有则合并（更新cookie和BasketDetail中的BasketId为查询出来的Basket表中的BasketId值），无则添加一条新的Basket记录，并将BasketId值置为Cookie中记录的basketid值。

# 4.cookie、token与csrf、xss关系

> cookie：登陆后后端生成一个sessionid放在cookie中返回给客户端，并且服务端一直记录着这个sessionid，客户端以后每次请求都会带上这个sessionid，服务端通过这个sessionid来验证身份之类的操作。所以别人拿到了cookie拿到了sessionid后，就可以完全替代你。

> token：登陆后后端不返回一个token给客户端，客户端将这个token存储起来，然后每次客户端请求都需要开发者手动将token放在header中带过去，服务端每次只需要对这个token进行验证就能使用token中的信息来进行下一步操作了。

> csrf：跨站请求攻击，简单地说，是攻击者通过一些技术手段欺骗用户的浏览器去访问一个自己曾经认证过的网站并运行一些操作（如发邮件，发消息，甚至财产操作如转账和购买商品）。由于浏览器曾经认证过，所以被访问的网站会认为是真正的用户操作而去运行。这利用了web中用户身份验证的一个漏洞：**简单的身份验证只能保证请求发自某个用户的浏览器，却不能保证请求本身是用户自愿发出的**。csrf并不能够拿到用户的任何信息，它只是欺骗用户浏览器，让其以用户的名义进行操作。

> xss：用户通过各种方式将恶意代码注入到其他用户的页面中。就可以通过脚本获取信息，发起请求，之类的操作。

```
csrf例子：假如一家银行用以运行转账操作的URL地址如下： http://www.examplebank.com/withdraw?account=AccoutName&amount=1000&for=PayeeName
那么，一个恶意攻击者可以在另一个网站上放置如下代码： <img src="<http://www.examplebank.com/withdraw?account=Alice&amount=1000&for=Badman>">
如果有账户名为Alice的用户访问了恶意站点，而她之前刚访问过银行不久，登录信息尚未过期，那么她就会损失1000资金。
```

以上面的csrf攻击为例：

- cookie：用户点击了链接，cookie未失效，导致发起请求后后端以为是用户正常操作，于是进行扣款操作。
- token：用户点击链接，由于浏览器不会自动带上token，所以即使发了请求，后端的token验证不会通过，所以不会进行扣款操作。

> - 对于csrf来说，cookie容易被自动携带，token则不容易被自动携带。所以token防止csrf攻击。
> - 对于xss来说，cookie和token都被获取的话，全都的完蛋。

# 