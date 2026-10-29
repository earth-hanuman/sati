allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Force all Android plugin subprojects to compile against SDK 36.
// Some transitive deps (flutter_plugin_android_lifecycle) now require it,
// while older plugins (file_picker) still declare 34. Registered before the
// evaluationDependsOn block below so afterEvaluate runs in time.
subprojects {
    afterEvaluate {
        extensions.findByName("android")?.let { ext ->
            (ext as com.android.build.gradle.BaseExtension).compileSdkVersion(36)
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
