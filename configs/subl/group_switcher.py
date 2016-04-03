import sublime, sublime_plugin

class GroupSwitcher(sublime_plugin.WindowCommand):

  def goto_group(self, group_number):
    self.window.run_command('focus_group', { "group": group_number })

  def dual_mode(self):
    if self.direction == "left":
      self.goto_group(0)
    elif self.direction == "right":
      self.goto_group(1)

  def triple_mode(self):
    if self.direction == "left":
      self.goto_group(0)
    elif self.direction == "right":
      self.goto_group(1)
    elif self.direction == "up":
      self.goto_group(1)
    elif self.direction == "down":
      self.goto_group(2)

  def quarter_mode(self):
    if self.direction == "left":
      if self.group == 1:
        self.goto_group(0)
      elif self.group == 3:
        self.goto_group(2)
    elif self.direction == "right":
      if self.group == 0:
        self.goto_group(1)
      elif self.group == 2:
        self.goto_group(3)
    elif self.direction == "up":
      if self.group == 2:
        self.goto_group(0)
      elif self.group == 3:
        self.goto_group(1)
    elif self.direction == "down":
      if self.group == 0:
        self.goto_group(2)
      elif self.group == 1:
        self.goto_group(3)

  def select_mode(self, mode_number):
    switcher = {
        1: lambda: '',
        2: self.dual_mode,
        3: self.triple_mode,
        4: self.quarter_mode,
    }

    func = switcher.get(mode_number)
    return func()

  def run(self, **args):
    self.direction = args["direction"]
    self.group = self.window.active_group()
    self.layout = self.window.get_layout()

    cellsCount = len(self.layout["cells"])
    self.select_mode(cellsCount)
