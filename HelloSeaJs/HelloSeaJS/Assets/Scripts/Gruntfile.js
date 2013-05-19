module.exports = function (grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        // 指明哪些JS和css需要合并压缩...
        transport: {
            options: {
                paths: ['.'],
                alias: '<%= pkg.spm.alias %>'
            },
            // 指定文件夹
            scripts: {
                options: {
                    idleading: 'dist/'  // 模块id
                },
                files: {
                    '.build': ['main.js', 'util.js']    // 指明js文件 
                }
            }
        },

        // 合并
        concat: {
            // 名字随便
            main: {
                options: {
                    include: 'relative' // 说明自动根据依赖合并js文件
                },
                files: {
                    'dist/main.js': ['.build/main.js'],
                    'dist/main-debug.js': ['.build/main-debug.js']
                }
            }
        },

        // 压缩
        uglify: {
            main: {
                files: {
                    'dist/main.js': ['dist/main.js']
                }
            }
        },

        // 清理
        clean: {
            spm: ['.build']
        }
    });

    grunt.loadNpmTasks('grunt-cmd-transport');
    grunt.loadNpmTasks('grunt-cmd-concat');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.registerTask('build', ['transport', 'concat', 'uglify', 'clean']);
};
