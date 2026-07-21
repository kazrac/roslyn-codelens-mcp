{{- for namespace in usingNamespaces -}}
using {{namespace}};
{{~end~}}

namespace {{namespace}};

public class {{className}} : IEnumerable
{
	public IEnumerator GetEnumerator()
	{
		yield return CreateTestCase(
			{{~for member in members ~}}
				{{member.value}}{{if !for.last}},{{end}} //Set value for {{member.name.camelCase}}
			{{~end~}}
			)
			.SetName("[Test display name goes here]");

		yield return CreateTestCase(
			{{~for member in members ~}}
				{{member.value}}{{if !for.last}},{{end}} //Set value for {{member.name.camelCase}}
			{{~end~}}
			)
			.SetName("[Test display name goes here]");
	}

	private TestCaseData CreateTestCase(
	{{~for member in members ~}}
		{{member.type}} {{member.name.camelCase}}{{if !for.last}},{{end}}{{if for.last}}){{end}}
	{{~end~}}
	{
		return new TestCaseData(
		{{~for member in members ~}}
			{{member.name.camelCase}}{{if !for.last}},{{end}}
		{{~end~}}
		);
	}
}