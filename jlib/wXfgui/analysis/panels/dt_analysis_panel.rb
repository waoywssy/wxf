require 'java'

import javax.swing.tree.DefaultMutableTreeNode

module WxfGui
  
  class DtAnalysisPanel < JPanel
    include MouseListener
    
    def initialize(wXfgui)
      @wXfgui = wXfgui
      super()
      init
    end
  
    def init
      
      @dt_tree_listener = DtTreeModelListener.new
      @dt_tree = DtTree.new()
      @dt_tree.addTreeModelListener(@dt_tree_listener)
      @dt_jtree = JTree.new(@dt_tree)
     
      @t_scroll_pane_1 = JScrollPane.new(@dt_jtree)
      t_scroll_pane_2 = JPanel.new# PUT A PANEL HERE
      
           
      split_pane1 = JSplitPane.new JSplitPane::VERTICAL_SPLIT
      split_pane1.setDividerLocation 390
      split_pane1.add JPanel.new# Put a panel here
      split_pane1.add JPanel.new# Put a panel here
        
      
      split_pane2 = JSplitPane.new JSplitPane::HORIZONTAL_SPLIT
      split_pane2.setDividerLocation 300
      split_pane2.add @t_scroll_pane_1
      split_pane2.add split_pane1

      
      #
      # GROUP LAYOUT OPTIONS
      #
      
      layout = GroupLayout.new self
      # Add Group Layout to the frame
      self.setLayout layout
      # Create sensible gaps in components (like buttons)
      layout.setAutoCreateGaps true
      layout.setAutoCreateContainerGaps true
    
      sh1 = layout.createSequentialGroup
      sv1 = layout.createSequentialGroup
      p1 = layout.createParallelGroup
      p2 = layout.createParallelGroup
      
      layout.setHorizontalGroup sh1
      layout.setVerticalGroup sv1
    
      sh1.addComponent split_pane2
      sh1.addGroup p1
       
      p2.addComponent split_pane2
      sv1.addGroup p2
#=end      
    end
  
    
    def load_dt_tree
      idx = 0
      @wXfgui.base.selected_dt_items.each_with_index do |item, index|
        node = DefaultMutableTreeNode.new("#{item.name}")
        @wXfgui.base.add_default_mutable_nodes(node)
        @dt_tree.innerModel.insertNodeInto(node, @dt_tree.getRoot(), idx)
        idx = index + 1
      end
    end  
  
    def unload_dt_tree
      @wXfgui.base.dtmn.each do |item|
        @dt_tree.innerModel.removeNodeFromParent(item)
      end
      @wXfgui.base.remove_all_default_mutable_nodes
    end
  
  end
end