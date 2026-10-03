# 🚫 MuMu 模拟器开屏广告一键拦截工具 (MuMu AdBlock)
### Pure & Lightweight Startup Ad Blocker for NetEase MuMu Player

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Windows-0078D6.svg?style=flat-square&logo=windows" alt="Platform" />
  <img src="https://img.shields.io/badge/MuMu%20Player-v12%20%7C%20v6%20%7C%20Pro-blue.svg?style=flat-square" alt="Compatibility" />
  <img src="https://img.shields.io/badge/Size-%3C%205KB-brightgreen.svg?style=flat-square" alt="Lightweight" />
  <img src="https://img.shields.io/badge/Permission-Admin-orange.svg?style=flat-square" alt="Admin" />
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square" alt="License" />
</p>

---

## 📌 工具简介 (Overview)

网易 **MuMu 模拟器** 在每次冷启动时都会从服务器异步下载商业开屏推广海报，不仅延长了模拟器的启动时间，且容易消耗后台带宽与干扰游戏体验。

本工具是一个专为 Windows 平台打造的**纯净、极简、无任何多余依赖**的批处理工具：
- **纯粹去广告**：不篡改模拟器二进制文件，不注入 DLL，不触碰驱动与注册表。
- **一键双向切换**：支持一键开启拦截与一键还原恢复。
- **智能权限提升**：内置 UAC 提权逻辑，双击直接运行。

---

## 💡 拦截原理 (How It Works)

MuMu 模拟器在启动时会将网络下载的开屏广告图片缓存到如下固定目录中：
```text
%APPDATA%\Netease\MuMuPlayer\data\startupImage\
```

本脚本的防护机制：
1. **清理广告缓存**：自动扫描并彻底删除原有的 `startupImage` 广告图片目录；
2. **同名空文件占位**：在原路径创建名为 `startupImage` 的 **0 字节空白文件** 并施加只读锁（`attrib +r`）；
3. **物理级阻断**：Windows 文件系统不允许同一路径下同时存在同名的“文件”与“目录”。模拟器启动时尝试创建广告缓存目录将直接被底层文件系统拒绝，从而彻底阻断广告图片的写入与渲染，实现**秒级静音启动**。

---

## 🚀 使用方法 (Usage)

1. 点击仓库绿色 **`Code` ➔ `Download ZIP`**（或直接下载 [`mumu_adblock.cmd`](./mumu_adblock.cmd)）；
2. **直接双击** `mumu_adblock.cmd` 运行（会自动弹出管理员授权提示）；
3. 根据界面中文菜单进行选择：
   - 输入 `1` 并回车：**开启广告拦截**（推荐）
   - 输入 `2` 并回车：**恢复默认广告**
   - 输入 `3` 并回车：退出工具

---

## 📂 文件清单

```text
MuMu-AdBlock/
├── mumu_adblock.cmd      # 核心一键拦截批处理脚本 (带状态检测与交互菜单)
└── README.md             # 工具原理与使用说明
```

---

## ⚖️ 免责声明 (Disclaimer)

* 本项目仅用于个人提升软件使用体验的技术学习与测试；
* 所涉及的商标及模拟器所有权均归网易（NetEase）所有。