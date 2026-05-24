# 全自动配置引导（AI 客户端专用）

> 本文件与根目录 `README.md` 配合使用。AI 客户端读完 README 后，按本文件步骤执行即可完成**全部工具安装、环境配置、MCP 注册**。
>
> **目标机器**: Windows x64
> **安装基目录**: `D:\wangluo`（所有工具集中在此）
> **Python**: 3.14.5（`C:\Python314`）
> **Node.js**: v24.16.0
> **pnpm**: 11.2.2
> **最后更新**: 2026-05-23

---

## 当前状态总览

| 组件 | 状态 | 版本 | 路径 |
|------|------|------|------|
| Java JDK | ✅ | 21.0.11 | `D:\wangluo\jdk-21.0.11+10` |
| Python | ✅ | 3.14.5 | `C:\Python314` |
| Node.js | ✅ | v24.16.0 | `C:\Program Files\nodejs` |
| pnpm | ✅ | 11.2.2 | npm global |
| jadx | ✅ | 1.5.5 | `D:\wangluo\jadx` |
| apktool | ✅ | 3.0.2 | `D:\wangluo\apktool` |
| adb | ✅ | 1.0.41 | `D:\wangluo\platform-tools` |
| apksigner | ✅ | — | `D:\wangluo\bin\apksigner.bat` |
| zipalign | ✅ | — | `D:\wangluo\bin\zipalign.bat` |
| Frida | ✅ | 17.9.10 | `%APPDATA%\Python\Python314\Scripts` |
| radare2 | ✅ | 5.9.8 | `D:\wangluo\r2` |
| nmap | ✅ | 7.80 | `C:\Program Files (x86)\Nmap` |
| agent-browser | ✅ | 0.27.0 | npm global |
| playwright | ✅ | 1.60.0 | npm global |
| Ghidra | ✅ | 12.1 PUBLIC | `D:\wangluo\ghidra_12.1_PUBLIC` |
| GhidraMCP 插件 | ✅ | 1.4 | 已通过 Ghidra GUI 安装 |
| SecLists | ✅ | — | `D:\wangluo\SecLists-master` |
| ProxyCat | ✅ | — | `D:\wangluo\ProxyCat` |
| IDA Pro | ✅ | 9.3 | `D:\idapro` |
| ida-pro-mcp | ✅ | 2.0.0 | pip package |
| BurpSuite Pro | ✅ | 2026.4.2 | `D:\BurpSuite V2026.4.2` |
| BurpSuite MCP 扩展 | ✅ | 2.0.0 | `burp-mcp-full.jar` (63 tools) |
| Anything Analyzer | ✅ | — | `D:\anthing\Anything Analyzer` |
| jshookmcp | ✅ | latest | via npx |
| Skill 包 | ✅ | — | `D:\reverse-skill-private-main` |
| Claude 全局规则 | ✅ | — | `~/.claude/CLAUDE.md` |

> ✅ = 已安装可用 | ⚠️ = 需手动操作 | ❌ = 未安装

---

## 目录

1. [前置检查](#1-前置检查) ✅
2. [安装 Java JDK 21](#2-安装-java-jdk-21) ✅
3. [安装 APK 逆向工具链](#3-安装-apk-逆向工具链) ✅
4. [安装动态分析工具](#4-安装动态分析工具) ✅
5. [安装二进制分析工具](#5-安装二进制分析工具) ✅
6. [安装浏览器自动化](#6-安装浏览器自动化) ✅
7. [安装网络工具](#7-安装网络工具) ✅
8. [安装渗透辅助工具](#8-安装渗透辅助工具) ✅
9. [安装 Ghidra + GhidraMCP](#9-安装-ghidra--ghidramcp) ✅
10. [配置 IDA Pro MCP](#10-配置-ida-pro-mcp) ✅
11. [配置 Anything Analyzer MCP](#11-配置-anything-analyzer-mcp) ✅
12. [配置 jshookmcp](#12-配置-jshookmcp) ✅
13. [环境变量汇总](#13-环境变量汇总) ✅
14. [MCP 注册汇总](#14-mcp-注册汇总)
15. [验证清单](#15-验证清单)
16. [手动操作提醒](#16-手动操作提醒)

---

## 1. 前置检查 ✅

```powershell
# 确认基础环境
python --version     # 3.14.5
node -v              # v24.16.0
npm -v               # 11.13.0
pnpm --version       # 11.2.2
git --version        # 2.54.0
winget --version     # v1.28.240
curl --version       # 8.19.0
```

---

## 2. 安装 Java JDK 21 ✅

jadx、apktool、apksigner 都需要 Java。

已安装: `D:\wangluo\jdk-21.0.11+10`（Temurin OpenJDK）

```powershell
# 如需重新安装:
# curl -L -o D:\wangluo\jdk21.zip "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.11%2B10/OpenJDK21U-jdk_x64_windows_hotspot_21.0.11_10.zip"
# Expand-Archive -Path D:\wangluo\jdk21.zip -DestinationPath D:\wangluo -Force

# 验证
D:\wangluo\jdk-21.0.11+10\bin\java -version

# 环境变量（已设置）
# JAVA_HOME = D:\wangluo\jdk-21.0.11+10
```

---

## 3. 安装 APK 逆向工具链 ✅

### 3.1 jadx（Java 反编译器）✅

已安装: `D:\wangluo\jadx`（v1.5.5）

```powershell
# 验证
java -jar D:\wangluo\jadx\lib\jadx-1.5.5-all.jar --version
# 或通过 wrapper: D:\wangluo\jadx\bin\jadx.bat --version
```

### 3.2 apktool（APK 解包/重建）✅

已安装: `D:\wangluo\apktool`（v3.0.2）

```powershell
# 验证
java -jar D:\wangluo\apktool\apktool_3.0.2.jar --version
# 或通过 wrapper: D:\wangluo\apktool\apktool.bat --version
```

### 3.3 Android platform-tools（含 adb）✅

已安装: `D:\wangluo\platform-tools`（v1.0.41 / 37.0.0）

```powershell
D:\wangluo\platform-tools\adb.exe version
```

### 3.4 Android Build-Tools（含 apksigner + zipalign）✅

已安装: `D:\wangluo\android\build-tools\35.0.0`

```powershell
# 验证
java -jar D:\wangluo\android\build-tools\35.0.0\lib\apksigner.jar --version
D:\wangluo\android\build-tools\35.0.0\zipalign.exe
```

Wrapper 脚本:
- `D:\wangluo\bin\apksigner.bat` → `java -jar D:\wangluo\android\build-tools\35.0.0\lib\apksigner.jar %*`
- `D:\wangluo\bin\zipalign.bat` → `D:\wangluo\android\build-tools\35.0.0\zipalign.exe %*`

---

## 4. 安装动态分析工具 ✅

### Frida ✅

已安装: v17.9.10（pip: `frida-tools` 14.8.2）

```powershell
pip install frida-tools
# 验证
frida --version  # 17.9.10
frida-ps --version
```

> **注意**: Frida 安装在 `%APPDATA%\Python\Python314\Scripts\`。该目录已加入 User PATH，新终端可直接使用 `frida` 命令。

---

## 5. 安装二进制分析工具 ✅

### radare2（含 r2 / rabin2 / radiff2 / rahash2 / rasm2 / rax2）✅

已安装: `D:\wangluo\r2`（v5.9.8）

```powershell
# 验证
D:\wangluo\r2\radare2-5.9.8-w64\bin\radare2.exe -v
D:\wangluo\r2\radare2-5.9.8-w64\bin\rabin2.exe -v
```

> `D:\wangluo\r2\radare2-5.9.8-w64\bin` 已在 User PATH 中。

---

## 6. 安装浏览器自动化 ✅

### agent-browser + Playwright ✅

```powershell
npm install -g agent-browser playwright
npx playwright install chromium

# 验证
agent-browser --version   # 0.27.0
playwright --version      # 1.60.0
```

---

## 7. 安装网络工具 ✅

### Nmap ✅

已安装: `C:\Program Files (x86)\Nmap`（v7.80）

```powershell
winget install Insecure.Nmap --accept-source-agreements --accept-package-agreements --disable-interactivity
```

---

## 8. 安装渗透辅助工具 ✅

### ProxyCat（代理池管理）✅

已安装: `D:\wangluo\ProxyCat`

```powershell
git clone https://github.com/honmashironeko/ProxyCat.git D:\wangluo\ProxyCat
pip install -r D:\wangluo\ProxyCat\requirements.txt

# Wrapper: D:\wangluo\bin\proxycat.bat → python D:\wangluo\ProxyCat\ProxyCat.py %*
```

### SecLists（渗透测试词典）✅

已安装: `D:\wangluo\SecLists-master`

```powershell
# 已从 GitHub 下载并解压
```

---

## 9. 安装 Ghidra + GhidraMCP ⚠️

### Ghidra ✅ / GhidraMCP 插件 ✅

Ghidra 12.1 PUBLIC 已安装: `D:\wangluo\ghidra_12.1_PUBLIC`
GhidraMCP v1.4 已通过 Ghidra GUI 安装到: `%APPDATA%\ghidra\ghidra_12.1_PUBLIC\Extensions\GhidraMCP\`

```powershell
# 如需重新下载 Ghidra:
# $api = Invoke-RestMethod 'https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest' -TimeoutSec 15
# $asset = $api.assets | Where-Object { $_.name -like 'ghidra_*_PUBLIC_*.zip' } | Select-Object -First 1
# curl -L -o D:\wangluo\ghidra.zip $asset.browser_download_url
# Expand-Archive -Path D:\wangluo\ghidra.zip -DestinationPath D:\wangluo -Force

# 如需重新下载 GhidraMCP:
# $api2 = Invoke-RestMethod 'https://api.github.com/repos/LaurieWired/GhidraMCP/releases/latest' -TimeoutSec 15
# $pluginAsset = $api2.assets | Where-Object { $_.name -like '*.zip' } | Select-Object -First 1
# curl -L -o D:\wangluo\ghidra_12.1_PUBLIC\Extensions\GhidraMCP-1-4.zip $pluginAsset.browser_download_url

# 启动包装器: D:\wangluo\bin\ghidra.bat
```

> **MCP 服务**: 启动 Ghidra 并打开项目后，MCP 自动监听 `localhost:8765`（当前未运行）。

---

## 10. 配置 IDA Pro MCP ✅

### 前置条件

- IDA Pro 9.3 已安装（路径：`D:\idapro`）
- Python 3.14.5
- ida-pro-mcp 2.0.0 已安装

### 当前状态

```powershell
# 环境变量（已设置）
# IDADIR = D:\idapro

# pip 安装（已完成）
pip install git+https://github.com/mrexodia/ida-pro-mcp.git

# IDA MCP 插件安装（需交互）
ida-pro-mcp --install
# 选择: Streamable HTTP → Global → 全选客户端（Claude/Cursor 等）

# 启动 HTTP 服务器
idalib-mcp --host 127.0.0.1 --port 13337
```

> **当前状态**: IDA Pro MCP 服务在端口 13337 **在线**（IDA Pro 已运行且插件已加载）。
> 多实例时端口递增 (13337→13338→...)，检查 IDA Output 窗口的 `[MCP] port=xxxxx` 日志。

### MCP 注册

```json
// Claude Code (~/.claude/mcp.json)
{
  "mcpServers": {
    "idapro": {
      "url": "http://127.0.0.1:13337/mcp"
    }
  }
}
```

---

## 11. 配置 Anything Analyzer MCP ✅

### 当前状态

- 桌面应用已安装: `D:\anthing\Anything Analyzer`
- MCP 服务在端口 23816 **在线**

### 手动配置步骤（如果服务未启动）

```powershell
# 编辑 MCP 配置启用服务
# 文件位置: %APPDATA%\anything-analyzer\mcp-server-config.json
# 修改内容:
#   "enabled": true,
#   "port": 23816,
#   "authEnabled": true,
#   "authToken": "xxx-xxx-xxx"  (从应用获取)

# 重启应用使配置生效
```

### MCP 注册

```json
// Claude Code (~/.claude/mcp.json)
{
  "mcpServers": {
    "anything-analyzer": {
      "url": "http://localhost:23816/mcp",
      "headers": {
        "Authorization": "Bearer <token>"
      }
    }
  }
}
```

---

## 12. 配置 jshookmcp ✅

jshookmcp 是 npx 包，不需要显式安装，注册 MCP 后自动拉起。

### MCP 注册

```json
// Claude Code (~/.claude/mcp.json)
{
  "mcpServers": {
    "jshook": {
      "command": "npx",
      "args": ["-y", "@jshookmcp/jshook@latest"],
      "env": {
        "JSHOOK_BASE_PROFILE": "search"
      }
    }
  }
}
```

---

## 13. 环境变量汇总 ✅

```powershell
# Java
[Environment]::SetEnvironmentVariable('JAVA_HOME','D:\wangluo\jdk-21.0.11+10','User')

# IDA
[Environment]::SetEnvironmentVariable('IDADIR','D:\idapro','User')

# PATH（当前已追加的条目）
# D:\wangluo\jdk-21.0.11+10\bin
# D:\wangluo\bin
# D:\wangluo\platform-tools
# D:\wangluo\jadx\bin
# D:\wangluo\apktool
# D:\wangluo\r2\radare2-5.9.8-w64\bin
# D:\wangluo\r2
# D:\wangluo\SecLists-master
# D:\wangluo\android\build-tools\35.0.0  (通过 bin wrapper 间接可用)
# C:\Program Files (x86)\Nmap
# %APPDATA%\Python\Python314\Scripts  (frida, ida-pro-mcp)
```

---

## 14. MCP 注册汇总

### Claude Code (`~/.claude/mcp.json`)

当前机器尚未创建此文件。需要手动创建并填入：

```json
{
  "mcpServers": {
    "idapro": {
      "url": "http://127.0.0.1:13337/mcp"
    },
    "anything-analyzer": {
      "url": "http://localhost:23816/mcp"
    },
    "jshook": {
      "command": "npx",
      "args": ["-y", "@jshookmcp/jshook@latest"],
      "env": {
        "JSHOOK_BASE_PROFILE": "search"
      }
    },
    "ghidra": {
      "url": "http://localhost:8765/mcp"
    },
    "burpsuite": {
      "command": "node",
      "args": ["D:\\reverse-skill-private-main\\burp-mcp-full\\mcp-bridge.js"]
    }
  }
}
```

> **注意**: `~/.claude/mcp.json` 尚不存在，MCP server 虽然已安装但 AI 客户端侧尚未注册。创建此文件后重启 Claude Code 即可调用。

---

## 15. 验证清单

```powershell
# 设置 PATH（新终端不需要，直接使用即可）
$env:JAVA_HOME = 'D:\wangluo\jdk-21.0.11+10'
$env:Path = 'D:\wangluo\jdk-21.0.11+10\bin;D:\wangluo\bin;D:\wangluo\platform-tools;D:\wangluo\r2\radare2-5.9.8-w64\bin;C:\Program Files (x86)\Nmap;C:\Users\zhaoxu\AppData\Roaming\Python\Python314\Scripts;' + $env:Path

Write-Output '=== 核心运行时 ==='
java -version
node -v
python --version

Write-Output '=== APK 工具 ==='
java -jar D:\wangluo\jadx\lib\jadx-1.5.5-all.jar --version
java -jar D:\wangluo\apktool\apktool_3.0.2.jar --version
adb --version

Write-Output '=== 动态分析 ==='
frida --version
frida-ps --version

Write-Output '=== 二进制分析 ==='
radare2 -v
rabin2 -v
radiff2 -v

Write-Output '=== Ghidra ==='
Test-Path D:\wangluo\ghidra_12.1_PUBLIC\support\analyzeHeadless.bat

Write-Output '=== 浏览器 ==='
agent-browser --version
playwright --version

Write-Output '=== 网络 ==='
nmap --version

Write-Output '=== 渗透辅助 ==='
Test-Path D:\wangluo\ProxyCat\ProxyCat.py
Test-Path D:\wangluo\SecLists-master

Write-Output '=== IDA ==='
Test-Path D:\idapro
ida-pro-mcp --help

Write-Output '=== Anything Analyzer ==='
Test-Path 'D:\anthing\Anything Analyzer\Anything Analyzer.exe'

Write-Output '=== MCP 服务端口 ==='
netstat -ano | Select-String ':13337'  # IDA Pro MCP
netstat -ano | Select-String ':23816'  # Anything Analyzer
# netstat -ano | Select-String ':8765'  # Ghidra MCP（需启动 Ghidra）

Write-Output '=== Skill 包 ==='
Test-Path D:\reverse-skill-private-main\skills\SKILL.md
Test-Path D:\reverse-skill-private-main\skills\routing.md
Test-Path D:\reverse-skill-private-main\skills\tool-index.md

Write-Output '=== Claude 全局规则 ==='
Test-Path $env:USERPROFILE\.claude\CLAUDE.md
```

---

## 16. 手动操作提醒

| 步骤 | 状态 | 说明 |
|------|------|------|
| **GhidraMCP 插件安装** | ✅ 已完成 | 已通过 Ghidra GUI 安装到 `%APPDATA%\ghidra\ghidra_12.1_PUBLIC\Extensions\GhidraMCP\` |
| **IDA Pro MCP 插件安装** | ✅ 已完成 | `ida-pro-mcp --install` 已执行，IDA 9.3 插件已加载，服务在线 (13337) |
| **Anything Analyzer** | ✅ 已完成 | 桌面应用已启动，MCP 监听 23816 |
| **Claude MCP 注册** | ⚠️ 待做 | 创建 `~/.claude/mcp.json` 并注册 idapro / anything-analyzer / jshook / ghidra |
| **重启终端** | ⚠️ 待做 | PATH 变更已写入注册表，新终端生效后 `frida` 可直接调用 |
| **重启 AI 客户端** | ⚠️ 待做 | MCP 配置变更后需重启才能生效 |
