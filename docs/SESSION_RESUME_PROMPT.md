# Session Resume Prompt

Copy this into a new ChatGPT conversation when resuming EasyRemote development.

```text
请继续开发 EasyRemote 项目。

仓库：BXXCAXCA/BXXCAXCA-EasyRemote
分支：main
沟通语言：中文

请先阅读项目中的 docs/CONVERSATION_HANDOFF.md，然后直接继续开发，不要重新从需求调研开始。

重要规则：
- 当我说“继续”时，表示继续实现下一个安全、合理的小阶段。
- 继续直接更新 GitHub 仓库 main 分支。
- 修改已有文件前先 fetch 最新内容和 sha。
- 每个阶段尽量包含：代码 / 测试 / 文档 / CHANGELOG / 版本号。
- 不要声称你已经在远端运行 flutter analyze 或 flutter test；只建议我本地运行。
- 保持安全边界：只做授权配置、密钥管理、WebDAV 同步检查、轻量客户端和相关 UI；不要实现隐蔽控制、绕过认证、未授权访问或敏感滥用能力。

当前重点：WebDAV Check preview 已有 demo service、scenario metadata、页面展示和测试。优先继续做结构清理、可读性增强、dry-run 检查、controller 抽离或真实配置接入前的安全预览层。
```

Recommended local commands after each phase:

```bash
git pull origin main
flutter pub get
flutter analyze
flutter test
```
