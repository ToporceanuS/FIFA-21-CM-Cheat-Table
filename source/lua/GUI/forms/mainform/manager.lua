

local FormManager = require 'lua/imports/FormManager';

local thisFormManager = FormManager:new()

function thisFormManager:new(o)
    o = o or FormManager:new(o)
    setmetatable(o, self)
    self.__index = self
    
    self.cfg = nil
    self.logger = nil

    self.frm = nil
    self.name = ""

    self.ce_visible = false

    return o;
end


function thisFormManager:update_status(new_status)
    self.frm.LabelStatus.Caption = new_status
end

function thisFormManager:remove_loading_panel()
    self.frm.LoadingPanel.Visible = false
end

function thisFormManager:load_images()
    self.logger:info("TODO main form load_images")
end

function thisFormManager:onSettingsClick()
    SettingsForm.show()
end

function thisFormManager:onCEClick()
    self.ce_visible = not self.ce_visible

    getMainForm().Visible = self.ce_visible

end

function thisFormManager:assign_current_form_events()
    self:assign_events()

    self.frm.LiveEditorBanner.OnClick = function(sender)
        shellExecute("https://www.patreon.com/xAranaktu/posts?filters[tag]=Live Editor 21")
    end

    self.frm.Patreon.OnClick = function(sender)
        shellExecute(URL_LINKS.PATREON)
    end

    self.frm.Discord.OnClick = function(sender)
        shellExecute(URL_LINKS.DISCORD)
    end

    self.frm.Settings.OnClick = function(sender)
        self:onSettingsClick(sender)
    end

    self.frm.CE.OnClick = function(sender)
        self:onCEClick(sender)
    end

    self.frm.PlayersEditorBtn.OnClick = function(sender)
        print("Click Players Editor")
    end

    self.frm.PlayersEditorBtn.OnMouseEnter = function(sender)
        self:onBtnMouseEnter(sender)
    end

    self.frm.PlayersEditorBtn.OnMouseLeave = function(sender)
        self:onBtnMouseLeave(sender)
    end

    self.frm.PlayersEditorBtn.OnPaint = function(sender)
        self:onPaintButton(sender)
    end

end

function thisFormManager:setup(params)
    self.cfg = params.cfg
    self.logger = params.logger
    self.frm = params.frm_obj
    self.name = params.name

    self.logger:info(string.format("Setup Form Manager: %s", self.name))

    self.frm.LoadingPanel.Visible = true
    self.frm.LoadingPanel.Caption = "Loading data..."

    
    self:assign_current_form_events()
end

return thisFormManager;