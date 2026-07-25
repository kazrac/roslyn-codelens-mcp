using RoslynCodeLens.Models;

namespace RoslynCodeLens.BackgroundTasks;

internal sealed class BackgroundTask : IDisposable
{
    public string TaskId { get; }
    public string ToolName { get; }
    public DateTimeOffset StartedAt { get; }
    public DateTimeOffset? CompletedAt { get; set; }
    public BackgroundTaskStatus Status { get; set; }
    public object? Result { get; set; }
    public string? ErrorMessage { get; set; }
    public string? ErrorCode { get; set; }
    public CancellationTokenSource Cts { get; }

    public BackgroundTask(string taskId, string toolName)
    {
        TaskId = taskId;
        ToolName = toolName;
        StartedAt = DateTimeOffset.UtcNow;
        Status = BackgroundTaskStatus.Running;
        Cts = new CancellationTokenSource();
    }

    public BackgroundTaskInfo ToInfo()
    {
        var endedAt = CompletedAt ?? DateTimeOffset.UtcNow;
        var elapsedSeconds = Math.Max(0, (long)(endedAt - StartedAt).TotalSeconds);
        return new(
            TaskId, ToolName, Status, StartedAt, CompletedAt, Result, ErrorMessage, ErrorCode,
            elapsedSeconds);
    }

    public void Dispose() => Cts.Dispose();
}
