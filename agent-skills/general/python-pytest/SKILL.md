---
name: python-pytest
description: Write high-quality, minimal Python tests with the pytest framework for a given code target.
---

# Python Pytest Writer

You will analyze code and generate high-quality pytest tests for a given target.

## Quality Standards

- Take your time to analyze the code thoroughly before generating test cases.
- Quality is more important than speed — read all relevant source files and rules carefully.
- Do not take shortcuts with test data — read the actual classes to use correct constructors and fields.

## Rules

- 使用标准的 `pytest` 格式（函数式测试 + 原生 `assert`，不需要 unittest.TestCase；不要用 unittest 风格）。
- 原则上新建一个 test 文件；只有在你认为确实有必要时才追加到现有 test 文件或新建多个文件——如果出现这种情况，必须先询问 user 再进行下一步。
- 所有的 test 放在项目根目录的 `tests/` 文件夹下，可以按照功能分类或放进子文件夹中（如 `tests/unit/`、`tests/integration/`）。
- 为了方便起见，每个 test 文件都必须有一个 `if __name__ == "__main__":` 块，让文件可以直接通过 `python <filename>.py` 启动；所有参数必须带默认值，方便直接调试。

## Workflow

1. 确定 target：用户指定的文件 / 类 / 函数（或一段贴出的代码）。
2. 通读相关源文件与项目规则，理解 public API、构造函数、字段与依赖，不要凭空猜测签名。
3. 决定测试文件位置与命名（默认 `tests/test_<module>.py`；模块较大时按功能拆分子文件夹）。
4. 生成测试：以函数式测试为主；共享状态用 `@pytest.fixture`，多组输入用 `@pytest.mark.parametrize`；用例覆盖正常路径、边界条件和关键异常路径。
5. 汇报时给出运行方式：`python -m pytest tests/test_<module>.py -v` 或直接 `python tests/test_<module>.py`。

## Template

```python
import pytest


def test_<behavior>() -> None:
    assert <actual> == <expected>


def test_<edge_case>() -> None:
    with pytest.raises(<ExpectedError>):
        ...


@pytest.fixture
def <fixture_name>() -> <type>:
    # 构造被测对象；所有参数带默认值，便于直接调试
    return <Constructor>(<args with defaults>)


@pytest.mark.parametrize("<arg>", [<case1>, <case2>])
def test_<parametrized>(<arg>) -> None:
    ...


if __name__ == "__main__":
    raise SystemExit(pytest.main([__file__]))
```

## Pitfalls

- 不要 mock 掉被测逻辑本身，mock 只用于外部依赖（IO、网络、时间等）；pytest 下优先用 `monkeypatch` 或 `unittest.mock`。
- 测试数据来自真实类/字段的合法取值，不要编造不会出现的输入。
- 单个测试文件保持聚焦；测试之间相互独立，fixture 作用域按需设置（默认 function，共享资源才用 module/session）。
- 新增/合并测试文件前先与 user 确认，不要擅自改动现有测试。
