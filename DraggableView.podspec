Pod::Spec.new do |s|
  s.name             = 'DraggableView'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DraggableView.'
  s.description      = 'Add long description of the pod here.'
  s.homepage         = 'https://github.com/IsaacDouglas/DraggableView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Isaac Douglas' => 'isaacdouglas2015@gmail.com' }
  s.source           = { :git => 'https://github.com/IsaacDouglas/DraggableView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'DraggableView/Classes/**/*'
end
