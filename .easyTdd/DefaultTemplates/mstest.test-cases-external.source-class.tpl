{{- for namespace in usingNamespaces -}}
using {{namespace}};
{{~end~}}

namespace {{namespace}};

public class {{className}}
{
	public static IEnumerable<object[]> GetTestCases()
	{
		yield return CreateTestCase(
		{{~for member in members ~}}
			{{member.value}}{{if !for.last}},{{end}} //Set value for {{member.name.camelCase}}
		{{~end~}}
		);

		yield return CreateTestCase(
		{{~for member in members ~}}
			{{member.value}}{{if !for.last}},{{end}} //Set value for {{member.name.camelCase}}
		{{~end~}}
		);
	}

	private static object[] CreateTestCase(
	{{~for member in members ~}}
		{{member.type}} {{member.name.camelCase}}{{if !for.last}},{{end}}{{if for.last}}){{end}}
	{{~end~}}
	{
		return new object[]
		{
		{{~for member in members ~}}
			{{member.name.camelCase}}{{if !for.last}},{{end}}
		{{~end~}}
		};
	}

	public static string GetDisplayName(MethodInfo methodInfo, object[] values)
	{
		return values.ToString();
	}
}