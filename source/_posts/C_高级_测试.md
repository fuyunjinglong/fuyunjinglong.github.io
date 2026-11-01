---
title: 测试
date: 2000-01-01 06:33:16
categories:
- C_高级
toc: true # 是否启用内容索引
---

# 测试模式

比如顶流框架：Vue,React,Element,Echarts

开发模式：Test-last（后置测试）与TDD（测试驱动开发）

三维保障：TestHost 绑定驱动 + Harness 交互验证 + 因果断言强制

# 测试分类

- 单元测试：Vitest（Vue/Vite生态首选）与 Jest（React经典）
- 组件/集成测试：@vue/test-utils，React Testing Library，以及Cypress/Playwright的组件测试模式
- E2E（端到端）测试：Playwright（微软出品，跨浏览器并行）与Cypress（SPA友好）

**E2E最佳实践**

> - 模板式生成(CAPPortal Website)：配置驱动(Deep-Engine/Rules)。采用Vitest + JSDOM进行HTTP Mock测试
> - 知识库式生成(CBCProdGrow Website)：零测试起步。基于整洁架构+SDD（安全驱动开发），采用Playwright+真实后端接口测试。
> - 导航式生成（Rcp Wbsite）：规范驱动。基于DDD分层+SDD规范链+learnings纠错脚本，采用Playwright+HTTP Mock测试
