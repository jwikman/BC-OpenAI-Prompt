# BC-OpenAI-Prompt

A simple page in Business Central, used for testing System and User Prompts against Azure OpenAI Services.

## Getting Started

Add your settings to access Azure OpenAI Services in the file `SecretsAndCapabilitiesSetup.Codeunit.al`:

```al
IsolatedStorageWrapper.SetSecretKey('your-secret-key-here');
IsolatedStorageWrapper.SetDeployment('your-deployment-model-here');
IsolatedStorageWrapper.SetEndpoint('your-endpoint-here');
```

1. Then install the app in your BC SaaS environment.
1. Search for the page "Test prompts with Copilot" in Business Central, and open it.
1. Enter a User Prompt and a System Prompt, and click "Generate" to see the response from Azure OpenAI Services.

If you have crafted some nice prompts, you can save them to the database by clicking "Save to History".
You can later retrieve them by clicking "Load from History".

## Background

This app was built during the BC AI Hackathon 2024, due to the lack of access to Azure OpenAI Studio.
