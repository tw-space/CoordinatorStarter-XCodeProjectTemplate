# Setup Instructions for Coordinator Starter Snapshot Tests

These test specs use [pointfreeco](https://github.com/pointfreeco)'s [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing) framework to bootstrap simple snapshot tests for all views.

Before running these snapshots, you must *either*...

1.  Add the **main branch** of my **personal fork** of *swift-snapshot-testing*, which adds missing screen sizes, from _https://github.com/tw-space/swift-snapshot-testing_, making sure to add to the **SnapshotTests** target.

*OR*

2.  Add the **original**, and **better maintained**, framework from _https://github.com/pointfreeco/swift-snapshot-testing_ to the **SnapshotTests** target, and then remove the screen size cases that fail.

Note the first run of snapshots will *always fail* as the framework creates reference images for the test cases. Running snapshots a second time will result in the tests passing.